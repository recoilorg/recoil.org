<script lang='ts'>
  import { onMount } from "svelte";

  const TAU = 2 * Math.PI;

  type Point = { x: number, y: number };

  function getRadianAngle(degreeValue: number) {
    return degreeValue * Math.PI / 180;
  }

  const main = (el: HTMLCanvasElement) => {
    const ctx = el.getContext('2d');
    if (!ctx) return;
    
    // get the width of the canvas
    const width = el.width;
    const height = el.height;
    // Rotate around the center
    ctx.translate(width / 2, height / 2);
    ctx.rotate(getRadianAngle(90));
    ctx.translate(-width / 2, -height / 2);
    ctx.translate(-120, 100);
    
    // Now the origin is in the top right
    drawGrid(ctx, 1, 1, 12, 8, {
      radius: 28,
      inset: 15,
      lineWidth: 19
    });
  };

  const defaultGridOptions = {
    radius: 30,
    sides: 6,
    inset: 0,
    diameter: 10,
    // Context
    lineWidth: 10,
    fillStyle: 'red',
    strokeStyle: 'black',
    lineJoin: 'round',
    // Other
    randomColors: null
  };

  const lerpBetweenColors = (color1: number[], color2: number[], t: number) => {
    const [r1, g1, b1, a1] = color1;
    const [r2, g2, b2, a2] = color2;
    return [
      r1 + (r2 - r1) * t,
      g1 + (g2 - g1) * t,
      b1 + (b2 - b1) * t,
      a1 + (a2 - a1) * t
    ];
  };

  const getColorForUV = (u: number, v: number) => {
    v = 1 - v; // because we've rotated by 90 degrees
    // I've hard coded these just for simplicity
    const color1 = [.75, .85, 1, 1]; // top left
    const color2 = [1, 1, 1, 1]; // bottom right

    // Make t the hypothenuse of the triangle
    const t = Math.sqrt(u * u + v * v) / Math.sqrt(2);

    return lerpBetweenColors(color1, color2, t);
  };

  const drawGrid = (
    ctx: CanvasRenderingContext2D,
    x: number,
    y: number,
    w: number,
    h: number,
    options = {}) => {
    const opts = { ...defaultGridOptions, ...options };
    const points = createPoly(opts);
    opts.diameter = opts.radius * 2;
    for (let gy = y; gy < y + h; gy++) {
      for (let gx = x; gx < x + w; gx++) {
        const normalisedX = gx / (x + w);
        const normalisedY = gy / (y + h);
        const color = getColorForUV(normalisedX, normalisedY);
        // convert the rgba array to a string
        ctx.fillStyle = `rgba(${color.map(x => x * 255).join(',')})`;
        ctx.strokeStyle = ctx.fillStyle;
        ctx.lineJoin = opts.lineJoin as CanvasLineJoin;
        drawPoly(ctx, gridToPixel(gx, gy, opts), points, opts);
      }
    }
  };

  const gridToPixel = (gridX: number, gridY: number, opts) => {
    const m = gridMeasurements(opts);
    return toPoint(
      Math.floor(gridX * m.gridSpaceX),
      Math.floor(gridY * m.gridSpaceY + (gridX % 2 ? m.gridOffsetY : 0))
    );
  };

  const drawPoly = (ctx: CanvasRenderingContext2D, origin: Point, points: Point[], opts) => {
    // ctx.strokeStyle = opts.strokeStyle;
    ctx.save();
    ctx.translate(origin.x, origin.y);
    polyPath3(ctx, points);
    ctx.restore();
    if (opts.lineWidth) ctx.lineWidth = opts.lineWidth;
    if (opts.fillStyle) ctx.fill();
    if (opts.strokeStyle) ctx.stroke();
  };

  const createPoly = (opts, points: Point[] = []) => {
    const
      { inset, radius, sides } = opts,
      size = radius - inset,
      step = TAU / sides;
    for (let i = 0; i < sides; i++) {
      points.push(toPolarCoordinate(0, 0, size, step * i));
    }
    return points;
  };

  const gridMeasurements = (opts) => {
    const
      { diameter, inset, radius, sides } = opts,
      edgeLength = Math.sin(Math.PI / sides) * diameter,
      gridSpaceX = diameter - edgeLength / 2,
      gridSpaceY = Math.cos(Math.PI / sides) * diameter,
      gridOffsetY = gridSpaceY / 2;
    return {
      diameter,
      edgeLength,
      gridSpaceX,
      gridSpaceY,
      gridOffsetY
    };
  };

  const polyPath3 = (ctx: CanvasRenderingContext2D, points: Point[]) => {
    const [{ x: startX, y: startY }] = points;
    ctx.beginPath();
    ctx.moveTo(startX, startY);
    points.forEach(({ x, y }) => { ctx.lineTo(x, y); });
    ctx.closePath();
  };

  const toPoint = (x: number, y: number) => ({ x, y }) as Point;

  const toPolarCoordinate = (
    centerX: number,
    centerY: number,
    radius: number,
    angle: number) => toPoint(
    centerX + radius * Math.cos(angle),
    centerY + radius * Math.sin(angle)
  );

  let canvasElement: HTMLCanvasElement | null = null;
  onMount(() => {
    if (!canvasElement) return;
    main(canvasElement);
  });
</script>
<canvas bind:this={canvasElement} width="380" height="560" class="absolute no-scrollbar" style="z-index:-1; display:block; animation: 2s ease-out 0s 1 fadeIn;"></canvas>

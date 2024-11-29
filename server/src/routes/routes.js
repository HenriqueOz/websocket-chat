import express from "express";

const router = express.Router();

router.get("/", (req, res) => {
  res.set("content-type", "application/json");

  res.send(
    JSON.stringify({
      message: "done",
    })
  );
});

export default router;

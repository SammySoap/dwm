import express from 'express';

const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', function(req, res) {
    res.redirect(`https://raw.githubusercontent.com/SammySoap/dwm/main/setup.sh`);
});

app.get('/:branch', function(req, res) {
    const branch = req.params.branch;
    console.log(branch);

    res.redirect(`https://raw.githubusercontent.com/SammySoap/dwm/${branch}/setup.sh`);
});

app.listen(PORT, function() {
    console.log(`[Server] -> Listening on port ${PORT}`);
});
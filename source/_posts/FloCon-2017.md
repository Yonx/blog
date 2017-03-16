---
title: FloCon 2017
date: 2017-01-15 22:11:00
tags:
 - FloCon
 - netflow
 - DRDoS
 - DDoS
---

Here is the slide of my talk on [FloCon 2017](http://www.cert.org/flocon/).

{% blockquote
    FloCon2017
    http://localhost:4000/2017/01/15/FloCon-2017/BackboneNetworkDRDoSAttackMonitoringAndAnalysis.pdf 
    Backbone Network DRDoS Attack Monitoring and Analysis.pdf
%}
{% endblockquote %}
* DRDoS accounts for over 60% of all DDoS, hard to track, annoying bandwidth consumption, larger & larger
* DNS ＋ NTP ＋ CharGEN reflection account for over 77% of all DRDoS events
* DRDoS amplifiers has been bing used heavily, over 30% of our detected DNS amplifiers are bing used for DRDoS right now
* DNS reflection using ANY query, NTP reflection using MONLIST command, CharGEN ..., all of little practical use
* Kill top amplifiers' in traffic, solve the majority problem, no effect to normal network, hands together, let's DO it.

---

Happy time at San Diego.


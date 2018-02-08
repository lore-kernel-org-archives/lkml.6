Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AH8x226/0V0AtghGWRMuq7RtQm1YDn1PoCOGehruPTn77Npe5MMZA+X4ZOgiEIZ+GNfhWSOighmL
ARC-Seal: i=1; a=rsa-sha256; t=1518110657; cv=none;
        d=google.com; s=arc-20160816;
        b=xR8IuINHzrr++pwhS+O5T7LQuGMWLwUQ93sJi3VQyOsrizuzALB1c3VuItH+g8NCPQ
         mmXPkPMNvNcLRzmmYnr18GInSPmKPajuP2HaNk6Bhvt+Ng7KyHwkPG7G4j47x8WV3PBe
         aEsAbVOSkdQxNWIel2V+bVk75Tb2Lja6OlhLzeNYbvecaYcdCdEidH48bbHFS0D6gfuF
         HkEIeUc6/HojxZ+gE8WRP9EejOUd8BrMgl5nSrnyiudqxdl8J6OSqKY9cbbOpzRJw8yT
         6XQPyhn47NdMWDsLYURc6/d7Hf6krnsp4SYhIGOhGCx6ktsCTUQlyEZiyZf8q4HTpayV
         Batw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:date:cc:to:from:subject
         :message-id:arc-authentication-results;
        bh=bZB5XuCxxt0wFafbSddgn66ymUH74Jib/V7Ajjehr6I=;
        b=tZZ1Mx9XCEvWaUVmfyKJuwRkfBpbbin0ITcOC01+/y33dX4JftYRUhpynlEjfetUmc
         EM9AN4B9k4X2QTCUg2+3xqGVFA23Xpw5saYHeVAaxB+XYPM2ZK94PYKqq2t8XK63nYim
         cCO8C5g2u3lMcS+jW8Xp6bpc7NYyMHh5KD/fbFDf5ClF8KN+e7jRQJRo22SztGfHLaL5
         voMGqzz7JrNul/X6y5odLTnFe0E+YcBpa6gd40Hij0Lxcy5Rv9zJfj4o6dQLtKCBsmyX
         VttJhiMMZ6TLUAVFURGKkAH8u7fc0Rwl/TYKHk+Rh9jflSVhPSv8J3c5I/f5QM3BGtdY
         cAqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.158 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.158 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:541:599:871:960:966:967:973:982:988:989:1000:1042:1260:1313:1314:1345:1359:1373:1437:1516:1518:1535:1543:1575:1594:1711:1730:1747:1764:1777:1792:2194:2196:2199:2200:2393:2525:2543:2553:2565:2682:2685:2691:2693:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3355:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:3889:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4118:4250:4321:4385:4605:5007:6117:6119:6506:6678:6747:6748:7281:7901:7903:7974:9025:9040:9108:10004:10394:10400:10848:11232:11604:11658:11914:12043:12555:12663:12679:12740:12895:12986:13161:13200:13229:13439:13845:14096:14181:14659:14721:21080:21433:21451:21611:21627:30012:30029:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: front43_5f482da8d054a
X-Filterd-Recvd-Size: 7011
Message-ID: <1518110653.14196.25.camel@perches.com>
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
From: Joe Perches <joe@perches.com>
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Rob Herring <robh@kernel.org>, Igor Stoppa <igor.stoppa@huawei.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, Andrew Morton
 <akpm@linux-foundation.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner
 <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Date: Thu, 08 Feb 2018 09:24:13 -0800
In-Reply-To: <CAOFm3uHNvGOh_ErxpG9VeHwMzHGvdoN5Xx_JSN8y+QhB32ivmw@mail.gmail.com>
References: <20180202154026.15298-1-robh@kernel.org>
	 <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
	 <CAL_JsqK+1Z_vuFE_po1VCxkSc112OFmgCiwM7F1S0mH6gw3KHQ@mail.gmail.com>
	 <1517598363.7489.126.camel@perches.com>
	 <CAOFm3uHNvGOh_ErxpG9VeHwMzHGvdoN5Xx_JSN8y+QhB32ivmw@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-99xgIrpnuZT4xl+j6tjx"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591854400808951262?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-99xgIrpnuZT4xl+j6tjx
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Thu, 2018-02-08 at 15:35 +0100, Philippe Ombredanne wrote:
> However checking that licenses ids are known and listed in the kernel
> doc is essential IMHO to avoid drift and insulate the kernel from SPDX
> updates. Case in point  the new SPDX "GPL-2.0-only" is NOT what was
> documented by tglx and therefore should not be used and banned until
> we update the doc accordingly. and until we update ALL the GPL-2.0 to
> GPL-2.0-only eventually which is best done at once.

Agree and I've attached what I believe to be a
reasonable script for that conversion only after
LICENSE directories are updated with the
appropriate and license files and after
Documentation/process/license-rules.rst is modified.

> Otherwise, this is
> going to be a total mess on top of a complicated topic that requires
> quite a bit of maintainer energy!

There will always be some energy requirement and
no doubt some legal advice involvement too.

In another vein:

The existing license files in spdx.org seem
somewhat sloppily edited and perhaps have less
clarity and precision than desired.

For instance:

If the newer SPDX descriptor "GPL-2.0-only" is to
be used, why does this license URL:

https://spdx.org/licenses/GPL-2.0-only.html

still contain the phrase ", or (at your option) any later version".

The current diff between GPL-2.0-only and GPL-2.0-or-later:

$ wget -q https://spdx.org/licenses/GPL-2.0-only.html
$ wget -q https://spdx.org/licenses/GPL-2.0-or-later.html
$ diff -U0 GPL-2.0-only.html GPL-2.0-or-later.html 
--- GPL-2.0-only.html	2017-12-28 12:17:20.000000000 -0800
+++ GPL-2.0-or-later.html	2017-12-28 12:17:22.000000000 -0800
@@ -15 +15 @@
-    <title>GNU General Public License v2.0 only | Software Package Data Exchange (SPDX)</title>
+    <title>GNU General Public License v2.0 or later | Software Package Data Exchange (SPDX)</title>
@@ -141 +141 @@
-      <h1 property="dc:title">GNU General Public License v2.0 only</h1>
+      <h1 property="dc:title">GNU General Public License v2.0 or later</h1>
@@ -144 +144 @@
-          <p style="margin-left: 20px;"><code property="spdx:name">GNU General Public License v2.0 only</code></p>
+          <p style="margin-left: 20px;"><code property="spdx:name">GNU General Public License v2.0 or later</code></p>
@@ -147 +147 @@
-          <p style="margin-left: 20px;"><code property="spdx:licenseId">GPL-2.0-only</code></p>
+          <p style="margin-left: 20px;"><code property="spdx:licenseId">GPL-2.0-or-later</code></p>
@@ -160 +160 @@
-          <p style="margin-left: 20px;">This license was released: June 1991 This refers to when this GPL 2.0 only is being used (as opposed to GPLv2 or later).</p>
+          <p style="margin-left: 20px;">This license was released: June 1991</p>
@@ -679 +679,2 @@
-        as published by the Free Software Foundation; version 2.
+	as published by the Free Software Foundation; version 2
+	or any later version.


I am not a lawyer, this is not legal advice, etc... but:

The "1991 This" use in the -only file seems be missing
a period.

In any case it is awkwardly phrased as "or later" perhaps
should not be referenced at all.

The GPL 2.0 license as published by the Free Software
Foundation includes the option for using later versions.

Perhaps the SPDX -only licenses should be more specific
when it uses the phrase "as published by the Free
Software Foundation; version <n>." to specifically
exclude the option of any later version.

--=-99xgIrpnuZT4xl+j6tjx
Content-Type: application/x-shellscript; name="update-licenses.sh"
Content-Disposition: attachment; filename="update-licenses.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKCmxpY2Vuc2Vfc2NyaXB0PSQobWt0ZW1wIC10IGNvbnZlcnQtU1BEWC1saWNl
bnNlcy5YWFhYWFhYWFgucGwpCmNhdCA8PCdFT0YnID4+ICRsaWNlbnNlX3NjcmlwdAoKb3VyICRi
YWxhbmNlZF9wYXJlbnMgPSBxci8oXCgoPzpbXlwoXCldKyt8KD8tMSkpKlwpKS87CgpzdWIgZGVw
YXJlbnRoZXNpemUgewoJbXkgKCRzdHJpbmcpID0gQF87CgoJcmV0dXJuICIiIGlmICghZGVmaW5l
ZCgkc3RyaW5nKSk7CgoJd2hpbGUgKCRzdHJpbmcgPX4gL15ccypcKC4qXClccyokLykgewoJCSRz
dHJpbmcgPX4gc0BeXHMqXChccypAQDsKCQkkc3RyaW5nID1+IHNAXHMqXClccyokQEA7Cgl9CgoJ
cmV0dXJuICRzdHJpbmc7Cn0KCmZvciBteSAkZmlsZW5hbWUgKEBBUkdWKSB7CglteSAkRklMRTsK
CglpZiAoJGZpbGVuYW1lIGVxICctJykgewoJCW9wZW4oJEZJTEUsICc8JlNURElOJyk7Cgl9IGVs
c2UgewoJCW9wZW4oJEZJTEUsICc8JywgIiRmaWxlbmFtZSIpIHx8CgkJCWRpZSAiJFA6ICRmaWxl
bmFtZTogb3BlbiBmYWlsZWQgLSAkIVxuIjsKCX0KCXVuZGVmICQvOwoJbXkgJGZpbGUgPSA8JEZJ
TEU+OwoJY2xvc2UgJEZJTEU7CgoJbXkgJHNwZHggPSAiU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IjsKCgkkZmlsZSA9fiBzL1xiJHNwZHhbIFx0XSooKD86XChbIFx0XSopKilHUEwoXGRcLlxkKS8k
c3BkeCBcMUdQTC1cMi9nOwoJJGZpbGUgPX4gcy9cYiRzcGR4WyBcdF0qKCg/OlwoWyBcdF0qKSop
KEw/R1BMLVxkXC5cZClcKy8kc3BkeCBcMVwyLW9yLWxhdGVyL2c7CgkkZmlsZSA9fiBzL1xiJHNw
ZHhbIFx0XSooKD86XChbIFx0XSopKikoTD9HUEwtXGRcLlxkKSg/IS1vci1sYXRlcnwtb25seSkv
JHNwZHggXDFcMi1vbmx5L2c7CgoJd2hpbGUgKCRmaWxlID1+IHMvXGIkc3BkeFsgXHRdKCRiYWxh
bmNlZF9wYXJlbnMpKD8hWyBcdF0qQU5EfFsgXHRdKk9SKS8kc3BkeCAuICcgJyAuIGRlcGFyZW50
aGVzaXplKCQxKS9leCkgewoJCTsKCX0KCglpZiAoJGZpbGVuYW1lIGVxICctJykgewoJCW9wZW4o
JEZJTEUsICc+JlNURE9VVCcpOwoJfSBlbHNlIHsKCQlvcGVuKCRGSUxFLCAnPicsICIkZmlsZW5h
bWUiKSB8fAoJCQlkaWUgIiRQOiAkZmlsZW5hbWU6IG9wZW4gZmFpbGVkIC0gJCFcbiI7Cgl9Cglw
cmludCAkRklMRSAkZmlsZTsKCWNsb3NlICRGSUxFOwp9CkVPRgoKZ2l0IGdyZXAgLS1uYW1lLW9u
bHkgIiRzcGR4IiB8IFwKICAgIGdyZXAgLXZQICJeKD86TElDRU5TRVMvfERvY3VtZW50YXRpb24v
cHJvY2Vzcy9saWNlbnNlLXJ1bGVzXC5yc3QpIiB8IFwKICAgIHhhcmdzIHBlcmwgJGxpY2Vuc2Vf
c2NyaXB0CgpybSAtZiAkbGljZW5zZV9zY3JpcHQK


--=-99xgIrpnuZT4xl+j6tjx--

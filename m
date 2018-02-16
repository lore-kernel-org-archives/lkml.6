Return-Path: <tomas.winkler@intel.com>
X-Google-Smtp-Source: AH8x227434oGRIltaYHRaUPzJoOKnj1hugTkQhSv/HuUZbW7v1+yyXeRaPhX+Fschcv3TRjBoeGc
ARC-Seal: i=1; a=rsa-sha256; t=1518815853; cv=none;
        d=google.com; s=arc-20160816;
        b=O2/r/1z5VLWwzgEdCYH2TUO5yFHwMjT0646x9m29xYgftHInE761aPi2NPC+EOQ9HL
         A2uzHTGy1PKEOjg2WFqWoNgQ1PVVihQ+eQhzQKb7RE1soi3P4AX9YUk3Wl5L6Yw1ZcmA
         dsoSk8Ti61jJXtpk9vpaPXhHO4zTuAE+DCNXGU/F7HyiF7Aqo1FeEcXRzxsFCeZrHkqz
         2kXTcCkCVS6LG0gx8xeeisNzMlFZvcLnS+5UzLA4UQ7QfaA2MAuYz2oBKkEjdP0uGPnC
         s19fpxShyAoc2fzhfB7h7mNCg3N6x+kiOPmLLXPSOkCrlcnUZVMPnrYZXD8UYLsBuzu5
         STSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=uzu+xThaS4RQVDlF/6q8nF8ShGvH/5WtGqWhgeE5IQc=;
        b=q1pBttuNC/MaNMnW8kKvChxofR1aTJg8ri4W+aSml80Cbq7ubIxG5kQmMJEIxv363q
         dRSGh5STylVSKCr8rFm2DMSRtOhYf++99gQM30eI8tgcRoOfrOrBfUtlpne3xhHkCdc7
         QT7i1WVCg/6injbzIxUgU73iZP/POZSGeAHdweXCafqT7UvrNJxtyRbThKjZR7vrxWxG
         nQEcH5q5lnTudhsEINMZ7Q9HZbwjXt4syJbVUqft+8kopGh6pR8DxGiI63lifvxlV+ok
         8m2hPXHTPtfonUk/Cj5M/5ZxtTQv6WIpkoy/9yvR4fw0YBO1xkgBR75kSSeR8mwt+qLJ
         HxRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tomas.winkler@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=tomas.winkler@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tomas.winkler@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=tomas.winkler@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="28658603"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc 4.16] mei: set device client to the disconnected
 state upon suspend.
Thread-Topic: [char-misc 4.16] mei: set device client to the disconnected
 state upon suspend.
Thread-Index: AQHTpYxJd/cYdF6C+E633q+6Ng4mh6OmsIKAgABawdA=
Date: Fri, 16 Feb 2018 21:17:28 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94221A91@hasmsx108.ger.corp.intel.com>
References: <20180214120329.16094-1-tomas.winkler@intel.com>
 <20180216101153.GA14170@kroah.com>
In-Reply-To: <20180216101153.GA14170@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjg5ZWJkZGMtNzE2OC00YWJhLWJlNGUtOThiYTZkNDkxMDhjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJocTVKVGxNNUJGeU52OWVYMzhHdWl1NENOSjVqWTk5YjFEWGdNUjcxREFQd2ZwdVdGSkUxUzJpcnZ1MFBGYnRzIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.252.16.211]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592377994478941002?=
X-GMAIL-MSGID: =?utf-8?q?1592593851543514510?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>=20
> On Wed, Feb 14, 2018 at 02:03:29PM +0200, Tomas Winkler wrote:
> > This fixes regression introduced by
> > commit 8d52af6795c0 ("mei: speed up the power down flow")
>=20
> In the future, put:
> 	Fixes: 8d52af6795c0 ("mei: speed up the power down flow")
>=20
> in your signed-off-by area so that we can track this more easily.
>=20
Will do, thanks for taking care of it.
Tomas

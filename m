Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AIpwx48Yn84/e4tDNTT5Ya33FqZShXk2+95HRuFjXjfEe4ey+juy/ZB6xLqh7nJkVQ8itbWvF867
ARC-Seal: i=1; a=rsa-sha256; t=1522505576; cv=none;
        d=google.com; s=arc-20160816;
        b=knU/Fie5e3lhGtJPnS68Dxexcl7d3GQ1hyCncjrQzmpvNkjmWeG3CWy7HLlCUHz2gj
         y4EzHmDirS0zEjW7fdSrU47koEEsm7c+77DkHBQnansid8PTocjfilHH54uSXJqxHrv5
         UKlaGNyFNNBxMY4NWiELWhYAtxaPhqld+bo7vFwhPy/SaCKAhE3iQRm+YeM/4jdZVwxW
         9YTF2dyYothLVlzDHLnbtD2EnNEy9Z6qNqm15f9kZvdrdcNrIkwb3Wgvq8YzIHG01DUr
         QJzSIjydQZoUK0FQx1htm+/Sh0qKqSUPPhE1nA1QdIcntsP12ZO/YRSfq0uDgnla5Thx
         qKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=/aEtftn8nwDaiMbYCkaEHxN/cU3wnOFUq1wJv45DzXU=;
        b=T8Iv5pJO0FemktoBevxu0dGxfkl9sTAfKeYjIxdWqUipjjsPG0baBbC5+k2EVQvJZ4
         zG8R+fkcY5DfKBpSHWiu4nt7VrlznIMPmHQcHwxkJ/pjZoDqKd9QtjBLSroNXYBLOu3s
         hxrKLRFZzpe2wxMFBiN3+6Y8u8EBalgqBOFjZwrovcGNCwACFSEyfX5Su86lwgncx3oB
         49YYAEkvIbCyEC/jZhlbvvcnvbF7WCpq1M674GUkiDhA00ijV2Kr6yvGYxpWIy/vYObR
         1hnkZ6cGPVh0fft35dd5uAAaXBaLT6eGJQLgLOZUVsJtkCjI4XY86AS6tBIsr5ov3nB9
         JNog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.45 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.45 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6119:7903:8603:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13141:13230:13255:13311:13357:13439:14039:14096:14097:14659:21080:21627:30054:30083:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: frame77_53a9c30dbde62
X-Filterd-Recvd-Size: 2059
Message-ID: <1522505573.11653.1.camel@perches.com>
Subject: Re: [PATCH v2 01/75] staging: ks7010: Use the ARRAY_SIZE() macro to
 calculate array sizes.
From: Joe Perches <joe@perches.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Quytelda Kahja <quytelda@tamalin.org>, gregkh@linuxfoundation.org,
	wsa@the-dreams.de, devel@driverdev.osuosl.org,
	driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Date: Sat, 31 Mar 2018 07:12:53 -0700
In-Reply-To: <20180331084150.e6uottdsdagtywbp@mwanda>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
	 <20180331060855.9452-1-quytelda@tamalin.org>
	 <1522478173.2210.53.camel@perches.com>
	 <20180331084150.e6uottdsdagtywbp@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432385681826765?=
X-GMAIL-MSGID: =?utf-8?q?1596462807348619982?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 2018-03-31 at 11:41 +0300, Dan Carpenter wrote:
> On Fri, Mar 30, 2018 at 11:36:13PM -0700, Joe Perches wrote:
> > On Fri, 2018-03-30 at 23:07 -0700, Quytelda Kahja wrote:
> > > This macro, provided in 'linux/kernel.h', will calculate the size
> > > more succinctly than a division operation.
> > 
> > It's nice that you send patches, but please try to send a
> > cover letter with your patch series.
> > 
> 
> There are obviously times when a cover letter is required but what's the
> point of that for this particular series?

practice

> > Also, 75 patches is quite a lot for a staging patch series.
> > 
> > Please try to send fewer patches in your series, say a
> > maximum of 20 or so and see what happens to those patches
> > before sending the next set.
> 
> Do we really care about that for staging?

It seems like it matters most for staging as the submitters
are the least experienced nd most likely to get something
wrong.

Start small and build.

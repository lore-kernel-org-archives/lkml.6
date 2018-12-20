Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E58C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFE4218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fKza5FU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388354AbeLTSBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:01:55 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49246 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbeLTSBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:01:55 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181220180154euoutp019a105f7e48a5e218bdebd3cddf5dd9a2~yHHW9vGqH2908029080euoutp01b
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 18:01:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181220180154euoutp019a105f7e48a5e218bdebd3cddf5dd9a2~yHHW9vGqH2908029080euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545328914;
        bh=RlL9NvBG5VaFAU0JgJNgT8yhrplQMhlhxfj/Bpuho9I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fKza5FU3EXXpa/jyoEjUE7DIMKHaR5Rqg+56a0dLXUZmt9gtDvw6/yNv/ZBPDCs3Q
         KKFzGftNtCp27ZCu87bNjZRASFv5L9i73+CqYudRTzULKYDl8BWPPsVHXsd0kPuqAK
         hETWocxIpdnsXXIcG+eKAb+u3+Ytw2Oukr3tkFAg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181220180153eucas1p1fa1a027fc736c00aca9d33155b9eb98d~yHHWYZTXf0830308303eucas1p14;
        Thu, 20 Dec 2018 18:01:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D2.5F.04441.119DB1C5; Thu, 20
        Dec 2018 18:01:53 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181220180152eucas1p1c593928697eb31f1bb5b64eb2a5864a3~yHHVU6YFy0830308303eucas1p13;
        Thu, 20 Dec 2018 18:01:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181220180152eusmtrp24fcba6c2601faa565002653a1c539f18~yHHVGsVsN1888718887eusmtrp2S;
        Thu, 20 Dec 2018 18:01:52 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-67-5c1bd9110730
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 04.1B.04284.F09DB1C5; Thu, 20
        Dec 2018 18:01:51 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181220180151eusmtip10c4b78a104277f3bf4f863efe3aae6e6~yHHUnlym02819528195eusmtip1r;
        Thu, 20 Dec 2018 18:01:51 +0000 (GMT)
Subject: Re: [PATCH] pxa168fb: trivial typo fix
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <eb565b21-65f9-74c8-e6f7-9dc2403b3090@samsung.com>
Date:   Thu, 20 Dec 2018 19:01:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181203114751.637390-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djP87qCN6VjDJ7P4LW48vU9m8WJvg+s
        Fpd3zWGzuPdyNovF+/2XmRxYPTat6mTzuN99nMljycHljB6fN8kFsERx2aSk5mSWpRbp2yVw
        ZVw+3MBScIm9Yu6Fl2wNjJPZuhg5OSQETCS6Vs0Bs4UEVjBKzDmt3cXIBWR/YZRYem0tM4Tz
        mVFi/9G3zDAdD09thUosZ5R4ebiZFcJ5zyjx/NNBJpAqYQF9iVmXloDNFRFQlph4aiETSBGz
        QBOjxJMzl8BGsQlYSUxsX8UIYvMK2EnMn38erJlFQFVi7c/XQHEODlGBCIn+M+oQJYISJ2c+
        YeliZOfgFDCVWFAHEmUWMJA4smgOK4QtL7H97Ryw2yQEutklvp88yQRxtIvEs/1HoWxhiVfH
        t7BD2DIS/3fOZ4JomM4o8ebXUhYIZz2jxJozx6A6rCUOH7/ICmE7Sqw70M0KcpuEAJ/EjbeC
        EJv5JCZtm84MEeaV6GgTgqhWk9iwbAMbzK6unSuhgeghcf5tG/MERsVZSD6bheSfWUj+WcDI
        vIpRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwnZz+d/zTDsavl5IOMQpwMCrx8F7YLh0j
        xJpYVlyZe4hRgoNZSYR3/SGgEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfRQgLpiSWp2amp
        BalFMFkmDk6pBsY5f9gZjjAWu5z/nSU8IUTubPfriVxP6tKcXmx1nG74cFXOW60VicG8n2Jf
        3lV6fMa9cOr7I+IcSX5/Xac88tNLOPRkr0HTnqZlt3h1ZVW/bw94lrwtZKP3j6PH7ojIHt92
        xfmvsPflv9v71aT41gX+bW/pP3qvXsL+4n/7w4/nv1hffSO+TOidEktxRqKhFnNRcSIAMJiA
        liMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xu7r8N6VjDKbNNLO48vU9m8WJvg+s
        Fpd3zWGzuPdyNovF+/2XmRxYPTat6mTzuN99nMljycHljB6fN8kFsETp2RTll5akKmTkF5fY
        KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZVw+3MBScIm9Yu6Fl2wNjJPZ
        uhg5OSQETCQentrKDGILCSxllPi5XrCLkQMoLiNxfH0ZRImwxJ9rXUDlXEAlbxkl1nb0sYMk
        hAX0JWZdWgI2R0RAWWLiqYVMEEUdjBI7u7+zgCSYBZoYJZYusASx2QSsJCa2r2IEsXkF7CTm
        zz/PBGKzCKhKrP35GiwuKhAhcethBwtEjaDEyZlPgGx2Dk4BU4kFdRAT9SR2XP/FCmHLS2x/
        O4d5AqPgLCQNs5CUzUJStoCReRWjSGppcW56brGhXnFibnFpXrpecn7uJkZghGw79nPzDsZL
        G4MPMQpwMCrx8Grsko4RYk0sK67MPcQowcGsJMK7/hBQiDclsbIqtSg/vqg0J7X4EKMp0AsT
        maVEk/OB0ZtXEm9oamhuYWlobmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoGR1/Iw
        y1+mj/c5k7axse3z84i+o5t5Ye32lLBy69DIRvGqXK1l7hvfO08uNK4//veiDMNaAd+nXkV6
        i5X/BZzw2T0zUryrc2MVy63pr4MnLrp5re78Ie1bJcw3H86dXFmju6z12c4Alp87Zy0S172q
        Ivl3ediCUKYlqsetHhwyEg7s/v29Q3ilEktxRqKhFnNRcSIAHKqrCaYCAAA=
X-CMS-MailID: 20181220180152eucas1p1c593928697eb31f1bb5b64eb2a5864a3
X-Msg-Generator: CA
X-RootMTR: 20181203114919epcas4p40f0094c4bb5d3614d2c67c6e68094aab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203114919epcas4p40f0094c4bb5d3614d2c67c6e68094aab
References: <CGME20181203114919epcas4p40f0094c4bb5d3614d2c67c6e68094aab@epcas4p4.samsung.com>
        <20181203114751.637390-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ added dri-devel ML & fbdev ML to Cc: ]

On 12/03/2018 12:47 PM, Lubomir Rintel wrote:
> A missing space in an error message.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Patch queued for 4.21, thanks.

> ---
>  drivers/video/fbdev/pxa168fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
> index e31340fad3c7..1410f476e135 100644
> --- a/drivers/video/fbdev/pxa168fb.c
> +++ b/drivers/video/fbdev/pxa168fb.c
> @@ -279,7 +279,7 @@ static void set_clock_divider(struct pxa168fb_info *fbi,
>  
>  	/* check whether divisor is too small. */
>  	if (divider_int < 2) {
> -		dev_warn(fbi->dev, "Warning: clock source is too slow."
> +		dev_warn(fbi->dev, "Warning: clock source is too slow. "
>  				"Try smaller resolution\n");
>  		divider_int = 2;
>  	}

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

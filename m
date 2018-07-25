Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834F4C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195F120882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q23OiDYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195F120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbeGYPzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:55:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33306 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbeGYPzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:55:38 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180725144335euoutp026389053b8cbbcd8dfc548fa5b95ef452~Eo79pS0NK0543405434euoutp02R;
        Wed, 25 Jul 2018 14:43:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180725144335euoutp026389053b8cbbcd8dfc548fa5b95ef452~Eo79pS0NK0543405434euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532529815;
        bh=Xi+HDIlEb62b0S4j49nzr0SM1OA2HK+UwrWMS6syvjg=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Q23OiDYv4tDyR+Ea7AQPizDHncJBF5bFm1kIDJoWdQ4gwbZqIhJ7sIG9lBWyUIMnT
         uCAEOGfvXusBTAYKUs7az8XTG8Gs7Ttav3zmdLpd4MszqU70nWLn0ab8cVZfdEJR/s
         OzGW32US3qLtx1pb6w0RSyk/7DVSka9fCTp9BYhQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180725144335eucas1p20b9d195bbd935b98223a23441d8e44f8~Eo79MY7CK1890718907eucas1p2L;
        Wed, 25 Jul 2018 14:43:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 90.00.61560.69C885B5; Wed, 25
        Jul 2018 15:43:34 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180725144334eucas1p17ed82f2681229e6f60835b48a5e16ede~Eo78WP4520689806898eucas1p1l;
        Wed, 25 Jul 2018 14:43:34 +0000 (GMT)
X-AuditID: cbfec7f5-207ff7000002f078-8f-5b588c968ea1
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F2.AB.04183.69C885B5; Wed, 25
        Jul 2018 15:43:34 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync3.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCF004RMFKMQT70@eusync3.samsung.com>; Wed, 25 Jul
        2018 15:43:34 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: thermal: samsung: Add SPDX license
 identifier
Date:   Wed, 25 Jul 2018 16:43:33 +0200
Message-id: <2385592.z8yee4uxt4@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180724200312.xs6u4nvhjckukkig@kozik-lap>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOd1pPRHRBq8+W1vMP3KO1WL+lWus
        Fv2PXzNbnD+/gd1i02Mg9/KuOWwWn3uPMFrMOL+PyWLp9YtMFq17j7BbPHnYx+bA7bFm3hpG
        j52z7rJ7LN7zkslj06pONo/NS+o9Pm+SC2CL4rJJSc3JLEst0rdL4MpYPbeHqWAmb8W2rbeZ
        Ghhvc3UxcnJICJhITOpfxNLFyMUhJLCCUWLCt2esEM5nRolnHZ/ZYKrO7prPBJFYxihxbkoz
        G4Tzm1Fi9o3n7CBVbAJWEhPbVzGC2CICmhLX/34HG8UscI1JovvZNrBRwgKBEq9m3wBrYBFQ
        lXg7+x0ziM0L1LDx0moWEFtUwEtiy752JhCbU8BC4sP1qVA1ghI/Jt8Dq2EWkJfYt38qK4St
        I3H22DpGkGUSArfZJGZNusUCcbeLxOX9CxkhbGGJV8e3sEPYMhKXJ3ezQDRMZ5R482splLOe
        UWLNmWNMEFXWEoePX4RawScxadt0oDM4gOK8Eh1tQhAlHhIHrx9hh4TFSkaJWz1nWScwysxC
        cu0sJNfOQnLtAkbmVYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIFp5PS/4193MO77k3SI
        UYCDUYmH94NdeLQQa2JZcWXuIUYJDmYlEV6Xw0Ah3pTEyqrUovz4otKc1OJDjNIcLErivNI+
        EdFCAumJJanZqakFqUUwWSYOTqkGxvQW86+3tLVKJTKXTjjy9NfLrgdHd9UtreB/9kZy42Hm
        QqEJ122Pfbudu3+60dPsBV8Uq2uezvms+v/5MtYPbSeCd0cb6y0M/lvV0pUvrSihds+rc2fQ
        2nd+U24IT9xyxWyrgqjEZAa7VC6h7C3W0+uWvnGJ+t539JSsX+zehfra1Qwf4pSVi5RYijMS
        DbWYi4oTAZnWjH8fAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t/xq7rTeiKiDTZ9ELCYf+Qcq8X8K9dY
        Lfofv2a2OH9+A7vFpsdA7uVdc9gsPvceYbSYcX4fk8XS6xeZLFr3HmG3ePKwj82B22PNvDWM
        Hjtn3WX3WLznJZPHplWdbB6bl9R7fN4kF8AWxWWTkpqTWZZapG+XwJWxem4PU8FM3optW28z
        NTDe5upi5OSQEDCROLtrPlMXIxeHkMASRokNk6cxgSSEBP4ySpzodgex2QSsJCa2r2IEsUUE
        NCWu//3OCtLALHCNSeLxjvdsIAlhAX+Jjj3vwIpYBFQl3s5+xwxi8wI1bLy0mgXEFhXwktiy
        rx1sAaeAhcSH61OZITavZpRofn6KDaJBUOLH5HtgDcwC8hL79k9lhbC1JNbvPM40gZF/FpKy
        WUjKZiEpW8DIvIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMw/Lcd+7llB2PXu+BDjAIcjEo8
        vB6O4dFCrIllxZW5hxglOJiVRHhdDgOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8543qIwSEkhP
        LEnNTk0tSC2CyTJxcEo1MF4zzNaIsT1WcSnt/R/rbY0zZA4aX3+Wou0aFrjCVvv7tHDRsnfz
        wmQOPanM3ezFtWnOjH1XVmoeLLaMNvEQslPtPPFI+Jtk6QEx5q+OP1h/OKk8jt1m8f2ZgMfz
        6nCf8IwJc/bc+uukeWzhut8R9QoTzK2lniZySCsevDBv0ZdY5qjNPky3+JVYijMSDbWYi4oT
        AYgAMUJ7AgAA
X-CMS-MailID: 20180725144334eucas1p17ed82f2681229e6f60835b48a5e16ede
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180718200318epcas3p16aed6c1725d6c1e63ea6b1ad209c5756
References: <CGME20180718200318epcas3p16aed6c1725d6c1e63ea6b1ad209c5756@epcas3p1.samsung.com>
        <2442216.oppRSGRAaL@amdc3058> <20180724200312.xs6u4nvhjckukkig@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 24, 2018 10:03:12 PM Krzysztof Kozlowski wrote:
> On Tue, Jul 24, 2018 at 06:46:35PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On Wednesday, July 18, 2018 10:02:50 PM Krzysztof Kozlowski wrote:
> > > Replace GPL license statement with SPDX license identifier (GPL-2.0+).
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >  include/dt-bindings/thermal/thermal_exynos.h | 12 +-----------
> > >  1 file changed, 1 insertion(+), 11 deletions(-)
> > > 
> > > diff --git a/include/dt-bindings/thermal/thermal_exynos.h b/include/dt-bindings/thermal/thermal_exynos.h
> > > index 0646500bca69..642e4e7f4084 100644
> > > --- a/include/dt-bindings/thermal/thermal_exynos.h
> > > +++ b/include/dt-bindings/thermal/thermal_exynos.h
> > > @@ -1,19 +1,9 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > 
> > This code should be GPL-2.0 only, original license statement is most
> > likely result of using wrong file as the source of copy-paste. So I
> > would like to have the license fixed first before doing conversion to
> > SPDX.
> 
> If you think that's the case, then it makes sense and please go ahead.
> As fair as I remember this required signed-off from all contributors...
> so probably just Lukasz and Eduardo?

git blame shows just Lukasz so his Ack should be enough.

I'm also fine with doing it in one patch like i.e. in commit a80ea4cb944e
("pata_bk3710: clarify license version and use SPDX header"), if you are
also fine with it could you please re-spin the patch (+Cc: Lukasz)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


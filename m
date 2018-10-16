Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA118C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796F020866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=chavero.com.mx header.i=@chavero.com.mx header.b="VxGQY4Io";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=chavero.com.mx header.i=@chavero.com.mx header.b="A6Tdhcrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796F020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chavero.com.mx
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeJPUMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:12:25 -0400
Received: from salida.aumenta.com.mx ([209.139.208.81]:50828 "EHLO
        salida.aumenta.com.mx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbeJPUMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:12:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by salida.aumenta.com.mx (Postfix) with ESMTP id 118FCC80273;
        Tue, 16 Oct 2018 06:20:36 -0600 (MDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chavero.com.mx;
        s=mail; t=1539692436;
        bh=7U7/zCOj4qUEsqhbRoOHsb4E+CUoGzHuVJIinTEQHII=;
        h=Subject:From:To:Cc:Date:References:In-Reply-To;
        b=VxGQY4IoFLet+kzEFaclrArKXn5T7STdfbl52D3NkVjMLp+ezs4J8CpfN5kV9/+yE
         MctceRvFdnvTXGzJxunCQa2hc/lMMsWZULW78tcn/A/5hTtqHokBgTmfTSi75hbNIe
         3hHVOzwFTCFa7ubnY7eS8DlowNwRHfLTSZ9ndcBw=
X-Virus-Scanned: amavisd-new at aumenta.com.mx
Received: from salida.aumenta.com.mx ([127.0.0.1])
        by localhost (trefilp.aumenta.com.mx [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id uuCENbOTMBo1; Tue, 16 Oct 2018 06:20:35 -0600 (MDT)
Received: from airsk8 (unknown [189.146.205.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ichavero@seispistos.com.mx)
        by salida.aumenta.com.mx (Postfix) with ESMTPSA id 35DF1C8006D;
        Tue, 16 Oct 2018 06:20:34 -0600 (MDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chavero.com.mx;
        s=mail; t=1539692435;
        bh=7U7/zCOj4qUEsqhbRoOHsb4E+CUoGzHuVJIinTEQHII=;
        h=Subject:From:To:Cc:Date:References:In-Reply-To;
        b=A6Tdhcrj1gwVAXTVxFSfmKhoBdmiXPo9+z8mt1HXLl8lh0zGxr1gw9wzLuwubou8t
         y39DhTCSt8YoH1krc4fTWtCNfrqiaELuRzeTftb+XbkbsB57JDQASF+y2DcDERTfwP
         9gGVwV+tIH85R4E807evZZ8Ml5Wyd7g2y0cmB2Eg=
Message-ID: <5cd87f8299de9fa0d2726a2d3fa2bdae349281be.camel@chavero.com.mx>
Subject: Re: [PATCH] Fix Code of Conduct ambiguities
From:   =?ISO-8859-1?Q?Iv=E1n?= Chavero <ichavero@chavero.com.mx>
To:     Joe Perches <joe@perches.com>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Date:   Tue, 16 Oct 2018 07:21:42 -0500
References: <20181014185241.4085197-1-ichavero@chavero.com.mx>
         <97e8ce1370ed45b771538c67712920322ecdd3aa.camel@perches.com>
In-Reply-To: <97e8ce1370ed45b771538c67712920322ecdd3aa.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El 14/10/18 a las 8:46 p. m., Joe Perches escribió:
> On Sun, 2018-10-14 at 13:52 -0500, Ivan Chavero wrote:
> > The language and focus of the CoC has some ambiguities that
> > could lead to conflicts that might distract maintainers and
> > contributors attention from the technical nature of the
> > Linux kernel.
> > This patch aims to clarify this problems and focus the document
> > to a more possitive, healthy and technical standpoint.
> 
> []
> > diff --git a/Documentation/process/code-of-conduct.rst
> > b/Documentation/process/code-of-conduct.rst
> 
> []
> > @@ -17,23 +19,22 @@ Our Standards
> >   Examples of behavior that contributes to creating a positive
> > environment
> >   include:
> >   
> > -* Using welcoming and inclusive language
> > -* Being respectful of differing viewpoints and experiences
> > -* Gracefully accepting constructive criticism
> > -* Focusing on what is best for the community
> > -* Showing empathy towards other community members
> > +* Using welcoming and inclusive language.
> > +* Being respectful of differing viewpoints and experiences.
> > +* Gracefully accepting constructive criticism.
> > +* Focusing on what is best for the community:.
> > +* Showing empathy towards other community members.
> > +* Use facts instead of opinions.
> 
> trivia:
> 
> bullet points do not need periods.
> 
> 

When there are complete sentences the period is optional according to 
the Oxford dictionary [1]

if it's bad form i can remove them.


[1] https://en.oxforddictionaries.com/punctuation/bullet-points




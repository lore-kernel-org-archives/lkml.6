Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34019C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0971C21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfAXLVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:21:46 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40583 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfAXLVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:21:45 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so4003644lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 03:21:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f+uMpjpOJpDChU3YkiVtXO2LCX2H/Hke280SCz0e38o=;
        b=EbHvSmbJiGsg89H06hrN6J2JWOREzCYDI05vleN+r+dH9U2TVZFDGsl8mBam/S4mvU
         3v8VOTWVW3sHLJDH7/zR1P4elEKOd25Vzh2OJ4GjsBxyJKkyCNlCTWCrkjh9N84dmMm1
         L2VG9V3k/lE3Ryvrc6r+2m+o9fH+oDC9eRlnoGZX2jVaTmumCsFO/zvAtJNkOQrh3g0i
         7cXDFk6L5V1l1nitXgx7FEUgyuhNLshYywSzffl7zVx2k9YIER39r+/sJffE0UrRMna9
         KswS63zkjVu4GI/Za96ervFKIgN7r1wyy2sxcRLp7hZtvXg+bO71IziTfbo3qk3TjjcY
         enbA==
X-Gm-Message-State: AJcUukeXHZGbDXdh39W8XqiPJLYzzTSPLytEB5yhEU3GWQZW5jWGtbZi
        +YXw+LQoSpjjPTear7q3sva7DLj8
X-Google-Smtp-Source: ALg8bN4PdkT0cMkRFUuOUjInyKCc0YHoVDyyCSXF6I2dfZK+iOJtsT1kUUgqP7i/HmMnRcsUVycXgw==
X-Received: by 2002:a19:910d:: with SMTP id t13mr4837034lfd.98.1548328903683;
        Thu, 24 Jan 2019 03:21:43 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id a62sm917627lfa.37.2019.01.24.03.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 03:21:43 -0800 (PST)
Date:   Thu, 24 Jan 2019 13:21:40 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] regulator: bd70528: Constify regulator_linear_range
 and regulator_ops
Message-ID: <20190124112140.GG2559@localhost.localdomain>
References: <20190124100209.12275-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124100209.12275-1-axel.lin@ingics.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Axel,

On Thu, Jan 24, 2019 at 06:02:07PM +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/bd70528-regulator.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

This looks good to me =)

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A618C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D771206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D771206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeIDSlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:41:37 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45733 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbeIDSlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:41:37 -0400
Received: by mail-oi0-f65.google.com with SMTP id t68-v6so6921197oie.12;
        Tue, 04 Sep 2018 07:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5EAIVf44R/L5afcIOQ/t9yvOZCxPJGEhUDQCEA+YqKk=;
        b=SXCctSIQtSuQjojy0CpxoTlAsKf3dYakLikAs7T7TvAzF+mITmYA2k3TWIqbQwz0J/
         5R+sbT83NrP/MqbL4BkH7hzTtoOqw6zrFzr/KRiwkB0hKl9uKlEAIyX68Em3fIEs7mET
         gspnqNB5lamapqPlg8kFc9pQfLVp5nKmlQEZuHczQwaIzEiyenJT73ZHRetEbqhgIrCW
         8atLxNPF9rTixpUuPzp3DYxj+obqbDmFwN3LQamJ+jAKauG0aPPvLASH0CzLUOob6UoV
         m/xplOReFndtkQH+7vZkOPwJSbU78/WYMglw2BahsYGdMiPTJjPMk3A2gD8ow1gpzI2G
         j3eg==
X-Gm-Message-State: APzg51CZ5eAkT2xfXBvcMU+3mHQvKwrnrM8UuB5sSZK4G+MnshjyF1ZD
        r6LXTgFqoMMfqnDO92vcYQ==
X-Google-Smtp-Source: ANB0VdZPJ4uG1GWERWaB5Mz8oPDEg/no5MfdQoGUPl24DPurmZ3xzigeEyWO0U3ullYVSJqbCBWy/A==
X-Received: by 2002:aca:56d1:: with SMTP id k200-v6mr14691471oib.319.1536070579633;
        Tue, 04 Sep 2018 07:16:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l204-v6sm13311420oia.45.2018.09.04.07.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 07:16:18 -0700 (PDT)
Date:   Tue, 4 Sep 2018 09:16:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     mark.rutland@arm.com, michal.simek@xilinx.com, bp@alien8.de,
        mchehab@kernel.org, leoyang.li@nxp.com, amit.kucheria@linaro.org,
        olof@lixom.net, sgoud@xilinx.com, anirudh@xilinx.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt: bindings: Document ZynqMP DDRC in Synopsys
 documentation
Message-ID: <20180904141618.GA5516@bogus>
References: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
 <1535722070-10394-3-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535722070-10394-3-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 06:57:48PM +0530, Manish Narani wrote:
> Add information of ZynqMP DDRC which reports the single bit errors that
> are corrected and the double bit errors that are detected.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../bindings/memory-controllers/synopsys.txt       | 27 ++++++++++++++++++----
>  1 file changed, 22 insertions(+), 5 deletions(-)

Please add acks/reviewed-bys when posting new versions.

Rob

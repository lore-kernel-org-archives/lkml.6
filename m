Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12225C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B17218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545239905;
	bh=I1DHH/hvVTX8mk4m30HUG7aGIPn/sKzpzU425wqfc2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xeVoOJ1S0W5WhJs5PAIddIOKNm39wm75BOGm56oA5USLq2zoHR57OGN855a/1GGZN
	 ABR+72wjk+VmZ3ugeUbD+QUXlCh95rAnENCORO+RfRaecbUHSUnWoY6xvNCJDlbOV7
	 223KLVmHh+GebroSfn5zR8OPZWDS+kP51m7vQYxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbeLSRSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:18:25 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:38285 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbeLSRSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:18:22 -0500
Received: by mail-ot1-f47.google.com with SMTP id e12so19816919otl.5;
        Wed, 19 Dec 2018 09:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rPa8w7tha2PydDG1LN9zzS6TtqN+eu3vw2rhfx7D1GE=;
        b=hcl9riys+eq6kQY39wYNhjy8FPlvT2Y5ZTC5ZA06QampIhtXEkACNc0Agu5ZtiouXS
         Gtm0bA5s0uEqsj+mMol9oChz7Nbn/ign97hsmQr9w5wAKbVxsNJQ9fGEuX4M9BFxFbai
         P13t9npVyw2ZJMsU+nIhaJ9n331rXTqdbAXOcndfDqSXef5nOngro8yP38CsRbUMK2+m
         pIX9SDO8pKPw96Fwz//7ul1SxQl4izlruuf1kAmSNebIqOaolyNWh5I0rHJVT52LLroh
         TfBC2LvhJ2eT0Pup4k5qkiEn08aB2O4o9zmUevFkqQhXBeG2I+aswyWICI9QduYpkLQ9
         U7Tw==
X-Gm-Message-State: AA+aEWYnBF4Za8E3e9fseus2YGjHzCnMEtT5gQZt+3Sk7oxOUlvBWPrG
        Z3JjAhTSUl5GX6VJxx99C3IqMfU=
X-Google-Smtp-Source: AFSGD/W7RF9R7gtlTMjTTTKGFXDjcaNfMmiIv15dYxH/ihqEDu5rx/RoRiPnLTR05NXd7sqnFOYdMQ==
X-Received: by 2002:a9d:7450:: with SMTP id p16mr14246364otk.247.1545239901869;
        Wed, 19 Dec 2018 09:18:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j11sm9137368oif.9.2018.12.19.09.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 09:18:21 -0800 (PST)
Date:   Wed, 19 Dec 2018 11:18:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Jiri Kosina <trivial@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mrvl,intc: fix a trivial typo
Message-ID: <20181219171820.GA31587@bogus>
References: <20181203114710.636840-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203114710.636840-1-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 12:47:10PM +0100, Lubomir Rintel wrote:
> s/whold/whole/.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../devicetree/bindings/interrupt-controller/mrvl,intc.txt      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

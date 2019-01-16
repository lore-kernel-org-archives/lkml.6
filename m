Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD88AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC906206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547635764;
	bh=h5Finl60Lp5X7zMSiLqpSBVjQCIX7wjKEljgw8VZ1xQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M0jIJi/BGzw2UzZFUIR4mW38kTmpljTroVuA9ztb0+3GuNL4lkNPiulG2LfRsOe5P
	 BsXb472StrGZZJLOGhMruJac1fyo+tQHBlCYVVF5OmE6dPJpzJjAy6fy6Zgm0ynJtP
	 aNCqbHIw5F3KaJNtUdxVd4s14ihNZa8qCmJTM5R4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392115AbfAPKtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:49:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731577AbfAPKtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:49:22 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 641E320657;
        Wed, 16 Jan 2019 10:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547635761;
        bh=h5Finl60Lp5X7zMSiLqpSBVjQCIX7wjKEljgw8VZ1xQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G2jc+7lHfEtjN8T5408MijRCwes83fdMpzbtAtnDM+DmW4IuXxVnztdgphb7XkKy1
         hlJV9aFTqTVz1kIw9sXpRiC+n45bq92se45Hj8JX4NIx7zySZngDeiR/q58YE+pLq4
         DcW52yGVPZPn+IdHGp/fJr07a6GdrFICdG8HJ9gI=
Date:   Wed, 16 Jan 2019 18:48:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH shawn/for-next v4 1/2] dt-bindings: arm: Add Y Soft IOTA
 Draco, Hydra and Ursa boards
Message-ID: <20190116104856.GK15808@dragon>
References: <1547562139-64730-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547562139-64730-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 02:22:44PM +0000, Vokáč Michal wrote:
> These are i.MX6DualLite/Solo based single board computers used
> in various Y Soft products.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Applied both, thanks.

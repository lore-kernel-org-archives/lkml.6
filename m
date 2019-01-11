Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53821C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164852177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547191038;
	bh=WnnIa9mo9jnDuzdibOx4R0fMqZlZnxgFEsb28EJTp1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nggDfG7ajD+jhjzAnRBJERpUuY18wWyH+gWqaagmdc4AiAuTPB9z8msuivuCoEwUc
	 1yBeCFKack0zB42l8xkF2EYRLiIGXp93JFy4h3yxwLRiPNSPbDD8Fll1hqk0d+3eYB
	 SNJBLlj7o/CdWsLHaprg+v8Sit4GelwbENjYiuZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbfAKHRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:17:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfAKHRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:17:17 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4F8D20872;
        Fri, 11 Jan 2019 07:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547191036;
        bh=WnnIa9mo9jnDuzdibOx4R0fMqZlZnxgFEsb28EJTp1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JEVxtXkevQYej/EMZ5q5dVKrXf5MZGIvQWgS8pq2XOn20WPOXxmihBtnz1qfMUAKg
         /NQ3bEUcIYjommQezCgJ6H2fQZ4Mg5a5rZbXqyDFIWu2ncqmH90f/+JV1ZHvkg3LaG
         B3qO5Xy8KcRdFdox27Yzzjm8kYv/By6Qe8rfXbLI=
Date:   Fri, 11 Jan 2019 15:17:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     TheSven73@googlemail.com, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/3] bus: imx-weim
Message-ID: <20190111071703.GC32649@dragon>
References: <20181217154800.7448-1-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217154800.7448-1-TheSven73@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 10:47:57AM -0500, Sven Van Asbroeck wrote:
> Sven Van Asbroeck (3):
>   dt-bindings: bus: imx-weim: document multiple address ranges per child
>     node
>   bus: imx-weim: support multiple address ranges per child node
>   bus: imx-weim: guard against timing configuration conflicts

Applied all, thanks.

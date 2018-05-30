Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752886AbeE3EHF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:07:05 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44317 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751010AbeE3EHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:07:02 -0400
X-ME-Proxy: <xmx:YyMOW42iVh9vGYAQPARnGOP1ugo0ZkSc728Xbn_JDTxxqNlRk1YNIA>
X-ME-Proxy: <xmx:YyMOW1CSA6iDh_TxuLcUgFKtsHZXoNwQTVzK6SLfMu8DystFPhzPGw>
X-ME-Proxy: <xmx:YyMOW7QfP7DWiqP3hfaA6ldxw86VahG3he1Nor51CsWcfZYcPHG4vw>
X-ME-Proxy: <xmx:YyMOW_JdvvZPwFA0IoWkyJpIbqZzoIOhjFaaGJRFDwWZzrwHwLmIjQ>
X-ME-Proxy: <xmx:YyMOW6FtIIina-vfWXvV2SfCfZqeorFyE4NC0dMBC7mDW2pR971_QQ>
X-ME-Proxy: <xmx:YyMOW3kxsw6iFeO2z28rvVVX0OWo8nezWDGmuGND-EvRwgpESyJsmg>
X-ME-Sender: <xms:YyMOW5_sWzP4A_PppxWlZpfUeRKlk-D6jW9c9GWUTIAZ0qNcbQ2gcA>
Message-Id: <1527653219.1600524.1389969792.6D07B793@webmail.messagingengine.com>
From: Andrew Jeffery <andrew@aj.id.au>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Joel Stanley <joel@jms.id.au>
Cc: Gunnar Mills <gmills@us.ibm.com>, openbmc@lists.ozlabs.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-397f98d6
In-Reply-To: <287c6a85-65ba-5782-e532-d17d517614f5@molgen.mpg.de>
Date: Wed, 30 May 2018 13:36:59 +0930
Subject: Re: Status of aspeed-bmc-opp-firestone (IBM S822LC)
References: <287c6a85-65ba-5782-e532-d17d517614f5@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, 30 May 2018, at 00:23, Paul Menzel wrote:
> Dear Joel, dear Linux folks,
> 
> 
> We have an IBM S822LC system (Firestone(?)). Building of OpenBMC 
> currently fails, as the not everything was ported from dev-4.10 to 
> dev-4.13 [1], and therefore a file cannot be found.
> 
> Looking at upstream Linux, there are BMCs for Power 8 systems, like 
> Palmetto, included.
> 
> ```
> $ ls arch/arm/boot/dts/aspeed-bmc-opp-*
> arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
> arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
> ```
> 
> Does somebody know, why Firestone was not upstreamed? Is somebody 
> working on upstreaming it? If not, do you have scripts to port such 
> work? Manually cherry-picking stuff in this case is hard, as there are a 
> lot of conflicts.

Firestone was never really maintained. We hacked around with it for a bit, but nothing concrete really came of it. As far as I'm aware, no-one is working on upstreaming it.

Also, I don't think there were any scripts used in the process, so it's going to be some drudge work to get things running.

Sorry that I don't have a more positive answer. Maybe someone else knows better.

Cheers,

Andrew

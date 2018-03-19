Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2530774-1521453641-2-10900285665539398665
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521453641; b=bRg/qiwqvPxVzA4bwW5bq6PHBDJtd9LKWSYMQm90FXztz99
    +9ATmg9BBnHZp9TZB2kKMcUlk27fgDer9Xu+Mzj9U9m3HpQ49dnhIzCNC8IOOsNw
    P56S97D8td6GqeBKAXOPOWhsEtA3vMCvleVw+SZAedBr/zbv4NS6fj6pR9IOOtvQ
    4KLOXtPI2Mc3MszjxsV6+uTqWuq3H4MokX1xmWRBg1+tMAbGiDCnmTgM7kiSRZ0D
    pWMh0aUR55KhNuJuFNtaCQtFYXAqYR3xCsGYM8Epzy0H2dul9V1rRk+uSzcPEAbm
    Q925LlK/fdY9h7CLSObIjedHjAZ/9s/Z6WZ3CeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=arctest; t=1521453641; bh=Gt8sVE
    hGzv7s0gKp5YpvJdZmIdSQ+BQicJ7i6ya9rI4=; b=tmCxkVrjwRKwRrhJQSYivK
    0XuC2OYrIc4RS6ngVXwZZNPZIURWKbqMjApOcb+S0G4pScaB5KlDnLZoO909T7IT
    CQeRQld335+5WX8mPsa0ZZ5OsezAgrmnSoTRo4FqY0WAy0wQFyEYanxZEYR0fzLf
    3PInM/V3nOnDnNUEg8opJo+rcs55GIHYbxCZkqboEVFJXhK3T+0dEeZbSlZF65m/
    urJiUwGw12HbFaV+MvSHT84tvE6znNjme2eKMv7rRf8Zm/mP8I/yh49NWctaNKhe
    t62bRI+FjCATUneT8ngvZQ21ixudrTc62Je+EgdgUQmVkkuMsntZIHvZT+BeKIYQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rjwysocki.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddtjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtshhpjeesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucfkphepvddtledrudefvddrudektddrieejpdejledrudekgedrvdehgedrvddvkeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefgeehheenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rjwysocki.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rjwysocki.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddtjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtshhpjeesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucfkphepvddtledrudefvddrudektddrieejpdejledrudekgedrvdehgedrvddvkeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefgeehheenucevlhhushhtvghrufhiiigvpeef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rjwysocki.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbeCSKAZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 06:00:25 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42474 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755302AbeCSKAY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 06:00:24 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, rafael.j.wysocki@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Mon, 19 Mar 2018 11:00:52 +0100
Message-ID: <2242415.DLYj1vY8hi@aspire.rjw.lan>
In-Reply-To: <20180318191215.10005-1-kai.heng.feng@canonical.com>
References: <20180318191215.10005-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sunday, March 18, 2018 8:12:15 PM CET Kai-Heng Feng wrote:
> USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
> core: Drop run_wake flag from struct dev_pm_info").
> 
> The device in question is not power managed by platform firmware,
> furthermore, it only supports PME# from D3cold:
> Capabilities: [78] Power Management version 3
>        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
>        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

That's somewhat unusual, but OK.

> Before the commit, the device never gets runtime suspended. After the
> commit, the device gets runtime suspended, so it does not respond to any
> PME#.
> 
> usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
> device_can_wakeup() in pci_dev_run_wake() always returns true.
> 
> So pci_dev_run_wake() needs to check PME wakeup capability as its first
> condition.
> 
> Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct dev_pm_info")
> Cc: stable@vger.kernel.org # 4.13+
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pci.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f6a4dd10d9b0..e026d8f313ec 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2125,16 +2125,13 @@ bool pci_dev_run_wake(struct pci_dev *dev)
>  {
>  	struct pci_bus *bus = dev->bus;
>  
> -	if (device_can_wakeup(&dev->dev))
> -		return true;
> -
> -	if (!dev->pme_support)
> -		return false;

Why are you removing this check?

> -
>  	/* PME-capable in principle, but not from the target power state */
> -	if (!pci_pme_capable(dev, pci_target_state(dev, false)))
> +	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
>  		return false;
>  
> +	if (device_can_wakeup(&dev->dev))
> +		return true;
> +
>  	while (bus->parent) {
>  		struct pci_dev *bridge = bus->self;
>  
> 

Thanks,
Rafael

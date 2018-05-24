Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162776-2-5755301888449942928
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES roenca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162776; b=Pj+cHHzgX9YZ+h+G5i7+Kwr5BKXb64hd41ELK2wUEzBH8LC5OF
    EZEpDcP43S4JtcQPBIOqXmDioKr1Hx9AfsK143Egs5LV25mcPszM3XUDKbj+VQgy
    onyWBXfv+2oa2PVIe7y8wP4B+XGxhmbBhVXdRt4twG04SsBJiZMEjQ1qyTJZP+6Z
    IT8PgL7Llizx8JtI9M70sm6KW3UZgg8qV/9Nx3FhcdiVEKTOhscdJep9rjPurS0V
    DCeD6Ml7wiguE03BsgEWYu9uCxNzCp1cVAvHLffkcROAd5qJWtu4Olsv18FhVbyh
    1t6ETlI8Bkh4l3/rzQabMEImyw3AS4oBCYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162776; bh=eV/f8VF54vt8tNUkaTwHKgw0jxFJaU
    NbuaELQsvyxuE=; b=ibC9vUAx8Age7+a5Wgv3Pb9/a8l/4JoL+X4ajkPkbK7dyA
    Yz56m4TKGZ6V7Hk0LXB0Ii4HbBJyS8mduhckFKkGl//JO4R6nXZ0hzdMbuY0dOfz
    K+hXTqmEpFzvnAy+C5rxh8lv2VGickjNCMS1BfoJgzes73tOYV0kPp1JR501RE20
    KfhTQoaPLtlieEzz8Xjv8o7xZbHqJHNxLvxvMmh4UIhvE10K0gXGowhrsMEgBxB/
    qW3cnOe+9D5bNTEKA6rH8kvgYa6ZkqBNRQFg8KIAmGYinP8ZYarvrslDBW7yq3g8
    H4ImBPGhYnPJTzYvVyjWmt+Qx3IB2olP88spE/3w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=L9K6WFNp x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=L9K6WFNp x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN4bA/WxvmvxZYWGDhQM5+obRD6ex3FiiBjXUlum3yjOiU5zyyDlbW6P4uTlS5UIoaF1AJplk5efXb8hpExCng9e53Wuo7w4JGIWz4OMCf+tghGIy47b
    w5CSEUB8Fn33V1WsqnV4zPLzBGJvcvEExQIo19/njfToOVYZSvdo2sZICTQhorAHxTrqRcFVhzGi1c+Swa/l85KLJL8gYoDVj7m9vZ8kyz16nzfu2K6XEg2L
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=yC-0_ovQAAAA:8 a=ag1SF4gXAAAA:8 a=lOMApQmIhMB7HfFht3IA:9
    a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=QsnFDINu91a9xkgZirup:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966977AbeEXLwj (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966510AbeEXJqc (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 4.4 89/92] gpio: rcar: Add Runtime PM handling for interrupts
Date: Thu, 24 May 2018 11:39:06 +0200
Message-Id: <20180524093207.768255027@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit b26a719bdba9aa926ceaadecc66e07623d2b8a53 upstream.

The R-Car GPIO driver handles Runtime PM for requested GPIOs only.

When using a GPIO purely as an interrupt source, no Runtime PM handling
is done, and the GPIO module's clock may not be enabled.

To fix this:
  - Add .irq_request_resources() and .irq_release_resources() callbacks
    to handle Runtime PM when an interrupt is requested,
  - Add irq_bus_lock() and sync_unlock() callbacks to handle Runtime PM
    when e.g. disabling/enabling an interrupt, or configuring the
    interrupt type.

Fixes: d5c3d84657db57bd "net: phy: Avoid polling PHY with PHY_IGNORE_INTERRUPTS"
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[fabrizio: cherry-pick to v4.4.y. Use container_of instead of
gpiochip_get_data.]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-rcar.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -200,6 +200,48 @@ static int gpio_rcar_irq_set_wake(struct
 	return 0;
 }
 
+static void gpio_rcar_irq_bus_lock(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct gpio_rcar_priv *p = container_of(gc, struct gpio_rcar_priv,
+						gpio_chip);
+
+	pm_runtime_get_sync(&p->pdev->dev);
+}
+
+static void gpio_rcar_irq_bus_sync_unlock(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct gpio_rcar_priv *p = container_of(gc, struct gpio_rcar_priv,
+						gpio_chip);
+
+	pm_runtime_put(&p->pdev->dev);
+}
+
+
+static int gpio_rcar_irq_request_resources(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct gpio_rcar_priv *p = container_of(gc, struct gpio_rcar_priv,
+						gpio_chip);
+	int error;
+
+	error = pm_runtime_get_sync(&p->pdev->dev);
+	if (error < 0)
+		return error;
+
+	return 0;
+}
+
+static void gpio_rcar_irq_release_resources(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct gpio_rcar_priv *p = container_of(gc, struct gpio_rcar_priv,
+						gpio_chip);
+
+	pm_runtime_put(&p->pdev->dev);
+}
+
 static irqreturn_t gpio_rcar_irq_handler(int irq, void *dev_id)
 {
 	struct gpio_rcar_priv *p = dev_id;
@@ -460,6 +502,10 @@ static int gpio_rcar_probe(struct platfo
 	irq_chip->irq_unmask = gpio_rcar_irq_enable;
 	irq_chip->irq_set_type = gpio_rcar_irq_set_type;
 	irq_chip->irq_set_wake = gpio_rcar_irq_set_wake;
+	irq_chip->irq_bus_lock = gpio_rcar_irq_bus_lock;
+	irq_chip->irq_bus_sync_unlock = gpio_rcar_irq_bus_sync_unlock;
+	irq_chip->irq_request_resources = gpio_rcar_irq_request_resources;
+	irq_chip->irq_release_resources = gpio_rcar_irq_release_resources;
 	irq_chip->flags	= IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
 
 	ret = gpiochip_add(gpio_chip);

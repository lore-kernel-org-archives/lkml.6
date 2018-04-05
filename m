Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeDELRB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeDELQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:16:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4D0217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AIpwx4/s67SXRlumrD132MT5UfPDjRW/W7fvq67fuSUY97AJnA3VQISs+f2S7Ozjjfy9+T7fKBTFLd+QtNsPZ2Ys0SY=
MIME-Version: 1.0
In-Reply-To: <20180404115147.16448-1-brgl@bgdev.pl>
References: <20180404115147.16448-1-brgl@bgdev.pl>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 5 Apr 2018 13:16:56 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf5hhDp8igbCJhFbOxTkbFgCwrJum0nuV1yNF0seZUeTA@mail.gmail.com>
Message-ID: <CAJKOXPf5hhDp8igbCJhFbOxTkbFgCwrJum0nuV1yNF0seZUeTA@mail.gmail.com>
Subject: Re: [PATCH] ARM: s3c24xx: mini2440: use device properties for at24 eeprom
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kukjin Kim <kgene@kernel.org>, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 1:51 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> We want to work towards phasing out the at24_platform_data structure.
> There are few users and its contents can be represented using generic
> device properties. Using device properties only will allow us to
> significantly simplify the at24 configuration code.
>
> Remove the at24_platform_data structure and replace it with an array
> of property entries. Drop the byte_len/size property, as the model name
> already implies the EEPROM's size.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Looks ok, I will take it after merge window.

Best regards,
Krzysztof

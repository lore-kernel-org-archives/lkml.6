Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754396AbeCGLko (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 06:40:44 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:33387 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbeCGLkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 06:40:42 -0500
X-Google-Smtp-Source: AG47ELvr/SMBeTVz8QpeU8qlwfLTUQc3NOHD0/HrrThzQfTjZt/ecWcF/BCaBm6kcbaLlg2q5lsWlH7GQ85YakJghkg=
MIME-Version: 1.0
In-Reply-To: <1520422436-9405-1-git-send-email-musashino.open@gmail.com>
References: <1520422436-9405-1-git-send-email-musashino.open@gmail.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Wed, 7 Mar 2018 12:40:40 +0100
Message-ID: <CACna6rwS+zQ4B4qk32qQk=ACg7PTV3sJ+5HYu+8Oj3Uf3ZzJxA@mail.gmail.com>
Subject: Re: [PATCH V2] ARM: dts: BCM5301X: add missing LEDs for Buffalo WZR-900DHP
To: musashino.open@gmail.com
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w27BemCl026211

On 7 March 2018 at 12:33,  <musashino.open@gmail.com> wrote:
> From: INAGAKI Hiroshi <musashino.open@gmail.com>
>
> Buffalo WZR-900DHP has 8 LEDs, but there is not LED definitions in the
> dts and cannot configure these LEDs.
> I Added missing LED definitions for WZR-900DHP.
>
> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>

Nice work, thanks!

Reviewed-by: Rafał Miłecki <rafal@milecki.pl>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754610AbeBATAy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 14:00:54 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:42869 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbeBATAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 14:00:44 -0500
X-Google-Smtp-Source: AH8x227SOQjkwj4lBbX8BWLxENR3WMU6fWQJ1i1SFzErjH800OpwIDOrkD6HUBqlhAjjW42wMnX4/Q==
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Andy Shevchenko'" <andy.shevchenko@gmail.com>,
        "'Niklas Cassel'" <niklas.cassel@axis.com>
Cc: "'Kishon Vijay Abraham I'" <kishon@ti.com>,
        "'Joao Pinto'" <Joao.Pinto@synopsys.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Niklas Cassel'" <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
References: <20180201161119.3852-1-niklas.cassel@axis.com> <20180201161119.3852-4-niklas.cassel@axis.com> <CAHp75VdX5=kzKFunM-Kbw7KOBt3+xik_pxhX1EZdO9eA3QHrBQ@mail.gmail.com>
In-Reply-To: <CAHp75VdX5=kzKFunM-Kbw7KOBt3+xik_pxhX1EZdO9eA3QHrBQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: designware-ep: Return an error when requesting a too large BAR size
Date: Thu, 1 Feb 2018 14:00:40 -0500
Message-ID: <000601d39b8e$f58a76f0$e09f64d0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIbMSTG4fR7CDNEjdPGIK+atFW6EADXJGl4AlTbNjqi51tV8A==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 1, 2018 1:58 PM, Andy Shevchenko wrote:
> 
> On Thu, Feb 1, 2018 at 6:11 PM, Niklas Cassel <niklas.cassel@axis.com>
> wrote:
> 
> include/linux/sizes.h:
> 
> +SZ_4G  0x100000000ULL
> 
> > +       if (size > 0x100000000ULL) {
> 
> #include <linux/sizes.h>
> 
> if (size > SZ_4G) {

I like this one for the readability.
Thank you.

Best regards,
Jingoo Han

> 
> ?
> 
> --
> With Best Regards,
> Andy Shevchenko

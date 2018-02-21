Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937867AbeBUP05 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:26:57 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:42323 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933308AbeBUP0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:26:55 -0500
X-Google-Smtp-Source: AH8x224k2/LhBMt2H+EAYScI2pWMc3pC39K96g7eoNF0c9PaMD/D7jv/rQBfrgBQGz5p+37fnyxozLLqDLUGS8C91HM=
MIME-Version: 1.0
In-Reply-To: <b40361cf40e8a73310d48ac775f7b324c08c7f95.1519225570.git.gdouezangrard@gmail.com>
References: <cover.1519225570.git.gdouezangrard@gmail.com> <b40361cf40e8a73310d48ac775f7b324c08c7f95.1519225570.git.gdouezangrard@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 17:26:54 +0200
Message-ID: <CAHp75Vd7P=23RVVKQ1+pu1sF=DE6xFG0CkjCjMJeqpQdoz3JHQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] revert "topstar-laptop: convert to module_acpi_driver()"
To: =?UTF-8?Q?Guillaume_Dou=C3=A9zan=2DGrard?=
        <gdouezangrard@gmail.com>
Cc: Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1LFR2fZ021663

On Wed, Feb 21, 2018 at 5:12 PM, Guillaume Douézan-Grard
<gdouezangrard@gmail.com> wrote:
> Revert commit 15165594da65 ("topstar-laptop: convert to
> module_acpi_driver()") to later add a platform device.

I would rather reindent this like

Revert commit
  15165594da65 ("topstar-laptop: convert to module_acpi_driver()")
to later add a platform device.

Subject should be
platform/x86: topstar-laptop: Revert "convert to module_acpi_driver()"

-- 
With Best Regards,
Andy Shevchenko

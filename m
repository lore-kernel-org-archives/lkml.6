Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbeEOQuS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:50:18 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40783 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752274AbeEOQuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:50:17 -0400
X-Google-Smtp-Source: AB8JxZrvVjGjGp6osx2Rmt/34TwB3aw6VF1ZL0M42qMeQIq0jwLSdS+UQZvydP8m/OLvf8G7cf5A0HwIq4w8jg2GZmk=
MIME-Version: 1.0
In-Reply-To: <CAHp75VeUbjobse6uLeM4h_xXRUw+YUQUN+EOye67AJy77a5euQ@mail.gmail.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com> <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
 <CAHp75VeUbjobse6uLeM4h_xXRUw+YUQUN+EOye67AJy77a5euQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 15 May 2018 19:50:16 +0300
Message-ID: <CAHp75VeM7_8+9QJjOypXaiBhpWP4B5KACdUQ-p3frbS3jPh=OQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] PCI: Rework of_pci_get_host_bridge_resources() to devm_of_pci_get_host_bridge_resources()
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 7:48 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, May 15, 2018 at 12:07 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

>> +                       devm_kfree(dev, res);

devm_kfree() makes my eyes hurt.

> res = devm_kmemdump();

devm_kmemdup(&tmp...);

-- 
With Best Regards,
Andy Shevchenko

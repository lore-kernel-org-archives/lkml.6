Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeDKE6F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 00:58:05 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:35297 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeDKE6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 00:58:02 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisNN2Ez2Y
X-RZG-CLASS-ID: mo00
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 1/4] gpio: pca953x: set the PCA_PCAL flag also when matching by DT
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAHp75VfCV4b5YWgYvkZkonz+TCn1JRD3idwLpEfcZTD99xqtxw@mail.gmail.com>
Date: Wed, 11 Apr 2018 06:57:51 +0200
Cc: Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com
Content-Transfer-Encoding: 7bit
Message-Id: <C3692040-E1EB-48A1-97C9-6F44DC2943BC@goldelico.com>
References: <cover.1523376423.git.hns@goldelico.com> <a5b37e5feff8a58dc63799ec76ef906695fd7239.1523376423.git.hns@goldelico.com> <CAHp75VcXpXZ+Ue7Cz0ORupgUjLTCiEwFYb2cs9kePX6EbEs-+w@mail.gmail.com> <CAHp75VfCV4b5YWgYvkZkonz+TCn1JRD3idwLpEfcZTD99xqtxw@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 10.04.2018 um 20:10 schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:
> 
> #define PCA_LATCH_INT (PCA_PCAL | PCA_INT)

Looks the best.

I have queued it for v4.

BR and thanks,
Nikolaus

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeFDVPc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:15:32 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33119 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbeFDVPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:15:30 -0400
X-Google-Smtp-Source: ADUXVKLjQYKPpzJAQWkymOksoPHsfrRUY9Jy4kD7TwvMJf3yAXrGWcSVVplOJZlRPveZDRL00KiBbA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc: Doug Berger <opendmb@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Justin Chen <justinpopo6@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] soc: bcm: brcmstb: pm: Add support for newer rev B3.0 controllers
Date: Mon,  4 Jun 2018 14:15:26 -0700
Message-Id: <20180604211526.21230-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180511220242.837-2-f.fainelli@gmail.com>
References: <20180511220242.837-1-f.fainelli@gmail.com> <20180511220242.837-2-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2018 15:02:41 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> From: Doug Berger <opendmb@gmail.com>
> 
> Update the Device Tree binding document and add a matching entry for the
> MEMC DDR controller revision B3.0 which is found on chips like 7278A0
> and newer.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> [florian: tweak commit message, make it apply to upstream kernel]
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to drivers/next, thanks!
--
Florian

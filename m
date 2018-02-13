Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965570AbeBMRvY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:51:24 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36484 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965206AbeBMRvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:51:23 -0500
X-Google-Smtp-Source: AH8x2259DgkwSFjoSox1dgs6Spp+rSMQHJr4rI+dYEf5pbNZzDwAmJCvl0L8SsRKK5YmLVFrXHDR3Mz4XLOKS69V0Cc=
MIME-Version: 1.0
In-Reply-To: <20180213170018.9780-13-mika.westerberg@linux.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com> <20180213170018.9780-13-mika.westerberg@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2018 19:51:21 +0200
Message-ID: <CAHp75Vcz8vpW0Ahev8NgpO6irV-btmvkrbyuTjXYdQitAw2HQQ@mail.gmail.com>
Subject: Re: [PATCH 12/18] thunderbolt: Add tb_xdomain_find_by_route()
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Radion Mirchevsky <radion.mirchevsky@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 7:00 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> From: Radion Mirchevsky <radion.mirchevsky@intel.com>
>
> This is needed by the new ICM interface to find xdomains by route string
> instead of link and depth.

> +       xd = switch_find_xdomain(tb->root_switch, &lookup);

> +       if (xd) {
> +               get_device(&xd->dev);
> +               return xd;
> +       }
> +
> +       return NULL;

return tb_xdomain_get(xd);

?

-- 
With Best Regards,
Andy Shevchenko

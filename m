Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeBTONC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 09:13:02 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34392 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeBTONA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 09:13:00 -0500
X-Google-Smtp-Source: AH8x224fLLCcExODganjezQlYhIVlKHPgAk+EzLMvyXA/cLQtoHZuNWilVtwaYEDSCd1XpW8NmjWjxkPEpOTsHznVw0=
MIME-Version: 1.0
In-Reply-To: <20180219225918.2311-2-mdf@kernel.org>
References: <20180219225918.2311-1-mdf@kernel.org> <20180219225918.2311-2-mdf@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 20 Feb 2018 16:12:59 +0200
Message-ID: <CAHp75VfKXe-7pzPT=9N3r20YV5Sq1UyHPoYwoLL1L4mjt8cEUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] power: reset: gpio-poweroff: Add support for
 timeout from DT
To: Moritz Fischer <mdf@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 12:59 AM, Moritz Fischer <mdf@kernel.org> wrote:
> Add support for reading a timeout value from devicetree.
> Fall back to previous default of 3s if nothing is specified.


> +       of_property_read_u32(pdev->dev.of_node, "timeout_ms", &timeout);

Perhaps stop being OF-centric by using device_property_read_u32() instead?

-- 
With Best Regards,
Andy Shevchenko

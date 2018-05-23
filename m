Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932656AbeEWLcv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:32:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57101 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbeEWLcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:32:48 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, Alexander.Deucher@amd.com,
        mturquette@baylibre.com, sboyd@kernel.org, christian.koenig@amd.com,
        airlied@redhat.com, Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add support for general system clock on ST AMD platform
Date: Wed, 23 May 2018 13:32:06 +0200
Message-ID: <1850531.osTZcrXkZF@aspire.rjw.lan>
In-Reply-To: <1525859941-23654-1-git-send-email-akshu.agrawal@amd.com>
References: <1525859941-23654-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 9, 2018 11:58:59 AM CEST Akshu Agrawal wrote:
> AMD ST/CZ platform provides a general system clock which can be used
> by any driver. Registration of this clock will done in clk-st driver.
> While the ACPI misc device will create the required MMIO mappings
> and pass the same to the clk-st driver. The clk-st driver will
> use the address to enable/disable and set frequency.
> 
> Changelog:
> v2:
>   clk: x86: Add ST oscout platform clock: v3->v4 unregister clk_hw
>   ACPI: APD: Add AMD misc clock handler support: No change (v2)
> v3:
>   clk: x86: Add ST oscout platform clock:
> 		v4->v5 use static array, change license
>   ACPI: APD: Add AMD misc clock handler support:
> 		v2->v3 use devm_ioremap, fix warning
> 
> Akshu Agrawal (2):
>   clk: x86: Add ST oscout platform clock
>   ACPI: APD: Add AMD misc clock handler support
> 
>  drivers/acpi/acpi_apd.c              | 50 ++++++++++++++++++++
>  drivers/clk/x86/Makefile             |  1 +
>  drivers/clk/x86/clk-st.c             | 88 ++++++++++++++++++++++++++++++++++++
>  include/linux/platform_data/clk-st.h | 35 ++++++++++++++
>  4 files changed, 174 insertions(+)
>  create mode 100644 drivers/clk/x86/clk-st.c
>  create mode 100644 include/linux/platform_data/clk-st.h
> 
> 

Both patches applied, thanks!

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeBTO0K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 09:26:10 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:38575 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeBTO0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 09:26:09 -0500
X-Google-Smtp-Source: AH8x224vCfNPr6XXvAhriybk1ExRl3xLdSii2mKXbfcPuJYx3QuFP2mryESrM6QYcHNGm4C+7RdtkQ==
Subject: Re: [PATCH v2] tpm: use kmemdup() to copy the event log
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: Nayna Jain <nayna@linux.vnet.ibm.com>,
        Thiebaud Weksteen <tweek@google.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
References: <20180220114129.9300-1-jarkko.sakkinen@linux.intel.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <7756fff1-ec94-1c26-9bbd-938337bc3c45@redhat.com>
Date: Tue, 20 Feb 2018 15:26:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220114129.9300-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/2018 12:41 PM, Jarkko Sakkinen wrote:
> Replaced kmalloc() + memcpy() in tpm_eventlog_efi.c and
> tpm_eventlog_of.c.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat

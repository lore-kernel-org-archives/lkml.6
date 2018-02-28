Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964843AbeB1XLb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:11:31 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:45563 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935599AbeB1XL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:11:29 -0500
X-Google-Smtp-Source: AG47ELsEX7e5gouDKG38USSOl4tYUyuI39E8HLqX3l6flvD0NA71T1VKdCrsCap+isLb1nCLJ0Rz+drfKw1zGJ1+7wY=
MIME-Version: 1.0
In-Reply-To: <20180228230747.GQ127842@bhelgaas-glaptop.roam.corp.google.com>
References: <1519045353-22496-1-git-send-email-dwmw@amazon.co.uk> <20180228230747.GQ127842@bhelgaas-glaptop.roam.corp.google.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 28 Feb 2018 15:11:28 -0800
Message-ID: <CAMo8Bf+P8Xfgg9Ww9EHRVVXud0OXW=3vtY94Gqz+BBLGEhxYyQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa: Use generic pci_mmap_resource_range()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>, Chris Zankel <chris@zankel.net>,
        linux-xtensa@linux-xtensa.org, Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Wed, Feb 28, 2018 at 3:07 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Feb 19, 2018 at 01:02:33PM +0000, David Woodhouse wrote:
>> Commit f719582435 ("PCI: Add pci_mmap_resource_range() and use it for
>> ARM64") added this generic function with the intent of using it
>> everywhere and ultimately killing the old arch-specific implementations.
>>
>> Let's get on with that eradication...
>>
>> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>
> Applied to pci/resource-mmap for v4.17, thanks!
>
> Xtensa folks, let me know if you have applied this or would like to, and
> I'll drop it.

Thank you, please keep it.
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

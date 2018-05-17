Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeEQRXw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:23:52 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40153 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbeEQRXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:23:50 -0400
X-Google-Smtp-Source: AB8JxZrXNjF1MHQO/WE5QN92YH3gBSqQlGmYUZFvdfqmmR6tQi8b+0LTpAYD9E9MxDoUrT2pEGF+2g==
Subject: Re: [PATCH INTERNAL 0/3] Add Broadcom PAXC related quirks
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
References: <1526577692-21104-1-git-send-email-ray.jui@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <025a6e7e-a6dc-c1ee-77cd-a78439bd17d9@broadcom.com>
Date: Thu, 17 May 2018 10:23:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526577692-21104-1-git-send-email-ray.jui@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn/Lorenzo,

My bad for having this "INTERNAL" tag in the subject. Please let me know 
if you need me to send out another set with that removed.

Thanks,

Ray

On 5/17/2018 10:21 AM, Ray Jui wrote:
> This patch series adds quirks to work around a few issues related to
> certain revisions of Broadcom PAXC based PCIe root complexes
> 
> This patch series is based off v4.17-rc5 and is available on GIHUB:
> repo: https://github.com/Broadcom/arm64-linux.git
> branch: sr-paxc-quirk-v1
> 
> Ray Jui (3):
>    PCI: iproc: Activate PAXC bridge quirk for more devices
>    PCI: iproc: Fix up corrupted PAXC root complex config registers
>    PCI: iproc: Disable MSI parsing in certain PAXC blocks
> 
>   drivers/pci/host/pcie-iproc.c | 34 ++++++++++++++-
>   drivers/pci/quirks.c          | 98 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 130 insertions(+), 2 deletions(-)
> 

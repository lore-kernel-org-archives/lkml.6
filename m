Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeCURMq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:12:46 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:37813 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbeCURMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:12:42 -0400
X-Google-Smtp-Source: AG47ELv3YfuCNbOnJGoiom+to9u2wHWVAcZ9cFmJZlS4xkQ60M9BU/gTeWBiPDdTs9UeKI1UXg0SSQ==
To: linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
From: valmiki <valmikibow@gmail.com>
Subject: Why two irq chips for MSI
Message-ID: <81eb7191-1c5c-ad27-2714-9563e4ef7c68@gmail.com>
Date: Wed, 21 Mar 2018 22:42:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In most of the RP drivers, why two irq chips are being used for MSI ?

One at irq_domain_set_info (which uses irq_compose_msi_msg and 
irq_set_affinity methods) and another being registered with struct 
msi_domain_info (which uses irq_mask/irq_unmask methods).

When will each chip be used w.r.t to virq ?

Thanks,
Valmiki

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

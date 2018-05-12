Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeELMz1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 08:55:27 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:42098 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeELMz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 08:55:26 -0400
X-Google-Smtp-Source: AB8JxZrACPELxJz5jKf227DRKjDdPrDxXnluS+JwhKO2K3G3bSm0sxAB9yAnVxLLAFaSuQSja5quWQ==
To: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
From: valmiki <valmikibow@gmail.com>
Subject: Difference between IOVA and bus address when SMMU is enabled
Message-ID: <c4fe00a3-33b1-7cd4-f613-768dee06ef6b@gmail.com>
Date: Sat, 12 May 2018 18:25:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

What is the difference between IOVA address and bus address
when SMMU is enabled ?

Is IOVA address term used only when hypervisor is present ?

Regards,
Valmiki

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752418AbeEOH6L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:58:11 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:61066 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbeEOH6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:58:09 -0400
Subject: Re: [PATCH v3 0/8] PCI: leak fixes, removable generic PCI host,
 assorted stuff
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will.deacon@arm.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <72f23e5f-4641-9ef3-09e6-70c4724f21a4@mentor.com>
Date: Tue, 15 May 2018 10:58:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <cover.1526363896.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 05/15/2018 08:58 AM, Jan Kiszka wrote:
> Changes in v3:
>  - refactor series to be both bisectable and simpler while reworking
>    of_pci_get_host_bridge_resources()
>  - include of_pci_get_host_bridge_resources() removal
>  - include devm_of_pci_get_host_bridge_resources() error path fixes
>  - effectively, no functional changes to v2

while the previous version of the changeset plus the fixup found on Bjorn's
pci/resource branch is sufficient, I can't argue with the fact that this
series is way better.

In case if this series is accepted I'll review and test the fix of
of_pci_get_host_bridge_resources() memleak again, no worries.

--
With best wishes,
Vladimir

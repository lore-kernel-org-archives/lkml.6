Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeECHPS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 03:15:18 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:50047 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbeECHPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 03:15:17 -0400
Subject: Re: [PATCH v2 05/10] PCI: Replace pr_*() with dev_*() in
 __of_pci_get_host_bridge_resources()
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <63f2e316090ea3284b4be62e446b3b28f998ac55.1525067324.git.jan.kiszka@siemens.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <57fa1919-80ea-df19-49a7-9d2d3e100d2e@mentor.com>
Date: Thu, 3 May 2018 10:15:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <63f2e316090ea3284b4be62e446b3b28f998ac55.1525067324.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30/2018 08:48 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Now that we have a device reference, make use of it for printing. And as
> long as dev can still be NULL, we will still get some reasonable output
> nevertheless.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Tested-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir

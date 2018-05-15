Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeEOH5M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:57:12 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:60996 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeEOH5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:57:10 -0400
Subject: Re: [PATCH v3 5/8] PCI: Replace pr_*() with dev_*() in
 of_pci_get_host_bridge_resources()
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
 <95f6ca417e2bc74d15f707e577b098e46b4b3ba4.1526363896.git.jan.kiszka@siemens.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <ae4ea7f6-b9a5-40ca-b0b3-4e55e7741fc4@mentor.com>
Date: Tue, 15 May 2018 10:57:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <95f6ca417e2bc74d15f707e577b098e46b4b3ba4.1526363896.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 08:58 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Now that we have a device reference, make use of it for printing.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Tested-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir

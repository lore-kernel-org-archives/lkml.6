Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeECHP3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 03:15:29 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:50060 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbeECHPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 03:15:25 -0400
Subject: Re: [PATCH v2 06/10] PCI: Introduce
 devm_of_pci_get_host_bridge_resources()
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <215a020abbafc599bda18463db6818fcb0d198c7.1525067324.git.jan.kiszka@siemens.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <38bb255b-925a-e373-1107-259734a15b9b@mentor.com>
Date: Thu, 3 May 2018 10:15:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <215a020abbafc599bda18463db6818fcb0d198c7.1525067324.git.jan.kiszka@siemens.com>
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
> of_pci_get_host_bridge_resources() allocates the resource structures it
> fills dynamically, but none of its callers care to release them so far.
> Rather than requiring everyone to do this explicitly, introduce a
> managed version of that service. This differs API-wise only in taking a
> reference to the associated device, rather than to the device tree node.
> 
> As of_pci_get_host_bridge_resources() is an exported interface, we
> cannot simply drop it at this point. After converting all in-tree users
> to the new API, we will phase out the unmanaged one.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Tested-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir

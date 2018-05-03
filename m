Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbeECHyd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 03:54:33 -0400
Received: from thoth.sbs.de ([192.35.17.2]:57753 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750773AbeECHyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 03:54:32 -0400
Subject: Re: [PATCH v2 08/10] PCI: Deprecate
 of_pci_get_host_bridge_resources()
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <aca0d89cd8c1551a83b87ffab29fcd6e1d59a61c.1525067324.git.jan.kiszka@siemens.com>
 <20180502123923.GA10783@infradead.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b13dd4b5-61c4-3acb-c194-3e448cb8b3d2@siemens.com>
Date: Thu, 3 May 2018 09:53:58 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20180502123923.GA10783@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-02 14:39, Christoph Hellwig wrote:
> On Mon, Apr 30, 2018 at 07:48:42AM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> There are no in-tree users remaining, all are converted to the managed
>> variant. And it is unlikely that any out-of-tree user got the resource
>> management right as well. So deprecate the interface and push users to
>> the managed version instead.
>>
>> To avoid raising a warning when exporting a deprecated symbol, wrap the
>> API with an inline and export an internal name.
> 
> Don't deprecated it, just remove it.
> 

I see a clear favorite now: consider this patch obsolete. I'll send a
separate removal patch, or a v3 of this series when otherwise needed.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935296AbeEIOzS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:55:18 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35227 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934331AbeEIOzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:55:16 -0400
X-Google-Smtp-Source: AB8JxZp0fFsJQr20IHeOMhHXyGu3aPa0l2xtcmCMMUlQ3Tqg8bI6o3nHzxm8pUlLhMDjUdeVKmIcrmA/5dKWA0zM/mw=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
In-Reply-To: <20180507101917.GA25806@lst.de>
References: <CAP8WD_YRPFSwqqUPy7AtmPs-0x4u+7V0rxWU75VnMh5HdLCA8w@mail.gmail.com>
 <20180507101917.GA25806@lst.de>
From: tedheadster <tedheadster@gmail.com>
Date: Wed, 9 May 2018 10:54:55 -0400
Message-ID: <CAP8WD_ZMiDN=9gkcwZC=4HRwQhUN_B5MVsbHQr_+iDDrF99tLw@mail.gmail.com>
Subject: Re: PCI: Regression in remove NULL device handling from PCI DMA API
To: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,
  that patch fixed the panic. Thank you for the fix. Please submit
them to the netdev mailing list.

- Matthew

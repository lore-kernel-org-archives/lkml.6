Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934339AbeCSXds (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:33:48 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:47016 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932534AbeCSXdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:33:45 -0400
Date: Mon, 19 Mar 2018 19:33:41 -0400 (EDT)
Message-Id: <20180319.193341.105600714432834778.davem@davemloft.net>
To: helgaas@kernel.org
Cc: khalid.aziz@oracle.com, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org, yinghai@kernel.org,
        linux-kernel@vger.kernel.org, david.ahern@oracle.com, linux@iam.tj,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        alex.williamson@redhat.com
Subject: Re: [PATCH v1 0/2] PCI: Sparc 64-bit resource fixups
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180319193854.GI77194@bhelgaas-glaptop.roam.corp.google.com>
References: <20180319171140.GA52750@bhelgaas-glaptop.roam.corp.google.com>
        <20180319.142831.793002554436316260.davem@davemloft.net>
        <20180319193854.GI77194@bhelgaas-glaptop.roam.corp.google.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 19 Mar 2018 14:38:54 -0500

> I'd be happy to remove both.  But I wonder how X init works on
> sparc.

It's been many years since I worked on this, but I think it
mapped and used the PCI ROM resource for this.

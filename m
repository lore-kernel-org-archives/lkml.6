Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeDDSjF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 14:39:05 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37216 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeDDSjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 14:39:03 -0400
X-Google-Smtp-Source: AIpwx4+GbLYmLsSmbBzhsXx+XHPYwWJfMpkXRXP859wjERsBCeCnvNdPljFAnmLfKO/4Lh0DStSeSf6gVPDI3QM3qZ0=
MIME-Version: 1.0
References: <20180403121415.20c4843e@canb.auug.org.au>
In-Reply-To: <20180403121415.20c4843e@canb.auug.org.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 04 Apr 2018 18:38:51 +0000
Message-ID: <CAErSpo5UpMrBn2VFyMD4VHvKnC04vGy5Wpzi76ZhD=ne6kdLtw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pci tree with the asm-generic tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>,
        linux-next list <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jesper@jni.nu, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 2, 2018 at 9:15 PM Stephen Rothwell <sfr@canb.auug.org.au>
wrote:

> Hi all,

> Today's linux-next merge of the pci tree got a conflict in:

>     arch/cris/arch-v32/drivers/pci/bios.c

> between commits:

>     c690eddc2f3b ("CRIS: Drop support for the CRIS port")
>     fd8773f9f544 ("arch: remove frv port")
>     739d875dd698 ("mn10300: Remove the architecture")

> from the asm-generic tree and commit:

>     31cbca85df15 ("PCI/MSI: Don't set up INTx if MSI or MSI-X is enabled")

> from the pci tree.

FWIW, I dropped the cris, frv, and mn10300 parts from my patch
(31cbca85df15).

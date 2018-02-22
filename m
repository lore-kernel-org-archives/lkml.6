Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933445AbeBVQVm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:21:42 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:48459 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933193AbeBVQVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:21:31 -0500
Date: Thu, 22 Feb 2018 17:21:13 +0100 (CET)
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
X-X-Sender: rolf@5HSWXM1.fritz.box
To: Andy Shevchenko <andy.shevchenko@gmail.com>
cc: Rolf Evers-Fischer <embedded24@evers-fischer.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: Re: [PATCH 1/2] pci: endpoint: Free func_name after last usage
In-Reply-To: <CAHp75VfgqqkLq0PbC0SBMCyCLqqoNZcUW0xngjacEL0VtAskmg@mail.gmail.com>
Message-ID: <alpine.LNX.2.20.1802221710110.1801@5HSWXM1.fritz.box>
References: <20180221124707.26308-1-embedded24@evers-fischer.de> <20180221124707.26308-2-embedded24@evers-fischer.de> <CAHp75VfgqqkLq0PbC0SBMCyCLqqoNZcUW0xngjacEL0VtAskmg@mail.gmail.com>
User-Agent: Alpine 2.20 (LNX 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HSB/Dpyzdoz4J8TI7gR+yxmgNowuud5hHHMw6sZ/RDv4SQKdu7G
 wujmrLOM4eykZD0aAvcpa30KkD/QVq2BHG+Lb4lYxP0xhWlco6FqcivcdxAHPLTEqes6Fih
 6D7eC0WvsVsCyGoYigchS0K9QmCGxqDT3J7jhTNhGa/ZVmRTP/5VRIXnZlwGwaLNQLCoF1/
 4lwJwi6rFq4vUgpdHWarw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JlCno/ViDVg=:6HrlzT+GIUxPfvDrEq2Mmd
 23r8jD358bSXBbun3j7oIMgojcPFsxdMj9LZhclwaBKdBFJa9rPTuijbPoJXJI69QZntFR7o6
 /OALBFM2+i2TN0kZWP+NaNx8qU++gKq75+wmQ5aNmcoCKHVTV65n7OKaXPFDD0s8Ay8HnKM1e
 DdtWPIsFxIv1LU0P4M0xDOo2oQdxWv6oGKbJAm8tzBrVbqRc+30YbmWPLqTuBq9dBTPu0sKlC
 iWc4n+nfFXwR41NK95yE9CQaCkEXOddvOua6xe6bvPWCYCJ7PINmiGRijmGqI1r0X/+iUEZlT
 sf4HbswWLRdsLsZTDQLTQyrrmBG+3L16E+VTH+jogTFecVTmmzFWO6Yzs5Q/6+sJsXsqeT5ii
 xcSL1H1dLhi+v+bBC+XkRD96dlM+ZugaIsmUG2g4NfLNMtm3SzvvApB0po4dYZ2I4XE5GEZha
 rpWEa3L53aB74AvBqzfQO7IHSlylrYkqgXcFXZJClBLyKK9ZdLVD5ljNm9PvG5uZy73MgxhaB
 7GES2MwWXzhcUCbMo0OQAROW4t99Ahs4lPnFpGhtYmRifJ0uDZsmS4ifzbcTo5T6vnYSDIYpC
 E7JPaGuuIC05Sn4ODwGmYz+r4MUEaG2UlK6a9ZuUXDLGNNG3Eg/bmXRDNDdsjWdatvStx9vnA
 7qdJC+SB6Fvfm8HG7b0s8Bga6B92oJ/iMtP9hBNd7pJgGK49W9ggp8rsxssTt+Us0wGMKbKsz
 nKUrbzqGrdRruTR9iAMIjWVooZpkSbTF4rFfyxPbRCjcg5muygWFN6iQHN0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Feb 2018, Andy Shevchenko wrote:

> > Change-Id: I0d1b6fd652395b85f82b11c43bf9b7db512854d1
> 
> First of all, this shouldn't be here.
>
Please excuse me. I know that I have to remove this, but
unfortunately I forgot to do so (here and also in the other patch).
 
> > Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> > Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
> 
> Looks like bipolar disorder?
>
You are right: One "Signed-off" should be enough.
 
> To the topic.
> This is a slow path and your change makes code slightly less readable
> b/c of patterns used in the kernel.
> 
I see. It is probably not a good idea to free the
memory in the middle of the function.
If you don't mind, I will remove this patch and change the other
one accordingly.

With best regards,
Rolf Evers-Fischer

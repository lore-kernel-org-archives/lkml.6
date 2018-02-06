Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AH8x22446nHDdCqzKRJS1P72oVMiUWEoUtHRQx9U6mbMsn1TYdNAwNQccXv2QJc2rAgXyV8ET9Te
ARC-Seal: i=1; a=rsa-sha256; t=1517924398; cv=none;
        d=google.com; s=arc-20160816;
        b=ZaHPbZQBYyo5lpHp1PhZZmFVRwuIk3hjbaMxkSlFR+z56Vroph5il3GdaUWxz5CAhb
         noYjqtZ3GHA0W6xXBHmqefthapGSXVim1yM1lqH3m2r97Qexd3QH2RMnryPUMxLk68cr
         S3UQEtuRpIJ3O/QYyPz7CBKLLUbRkggxaJk/xLkdhOJDjhZC4pB0Nrdlvai8LBfvfTf/
         Zargc7wWbpQUFyfe/xyDRZx/vHMzwmLPMqYRFXkN9CDR6t6oVN+KscQUSoFIfGEZdl2Y
         0lDKoWwK5jIGdPdsIyXHAZ0UzeR3up+caLzX+NZZzi1QGB0J92UkqMbuOM7JbJ1SuGkB
         yBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=VZXKSWNNrT5GtRhbdxhCwfSIVgiSSGyxvpwFIvc0IrQ=;
        b=a5rIrNM+gysgPzb16gi2AvofrBeLpnUHaI3MV1MRJ8umtLcMTlPQel1oZre9T9/Ra3
         AOdcnb2m5Ibcm9y2ngHBmtvrhhwem7n+9YAXerEcZ/fjaBVTHFJq747H7RuG4A3r5KuI
         z3mMmuCOixQmcx5GemeZ37v+cvzdMEuMqzcY3LkktXhEQlr917VWr80pRwfH112BebDN
         +EJ9pZy4zIVLMqj61FT7hZGMwhDAxL6HlSMsVLPxJborl2HvhS+h7JChfjUYObSspNIy
         pAO3+0SnrHAlqcyBfwXj/e52ZhX3bVmTz8sgs8QgISc21o91sifIHHK2GWOqFIKe6/bv
         9xyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 103.22.144.67 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 103.22.144.67 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: aik@ozlabs.ru, Alan Modra <amodra@gmail.com>, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>, "Aneesh Kumar K. V"
 <aneesh.kumar@linux.vnet.ibm.com>, anju@linux.vnet.ibm.com, Anton
 Blanchard <anton@samba.org>, Arnd Bergmann <arnd@arndb.de>, Thiago Jung
 Bauermann <bauerman@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, bhaktipriya96@gmail.com, Bjorn Helgaas
 <bhelgaas@google.com>, bryantly@linux.vnet.ibm.com, Balbir Singh
 <bsingharora@gmail.com>, Christophe Leroy <christophe.leroy@c-s.fr>,
 clombard@linux.vnet.ibm.com, Cyril Bur <cyrilbur@gmail.com>, Daniel
 Thompson <daniel.thompson@linaro.org>, david@gibson.dropbear.id.au, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, fbarrat@linux.vnet.ibm.com, Geert
 Uytterhoeven <geert+renesas@glider.be>, geoff@infradead.org,
 gomonovych@gmail.com, gpiccoli@linux.vnet.ibm.com,
 gromero@linux.vnet.ibm.com, "Gustavo A. R. Silva"
 <gustavo@embeddedor.com>, ivan@de.ibm.com, Jeremy Kerr <jk@ozlabs.org>,
 joakim.tjernlund@infinera.com, Joe Perches <joe@perches.com>, Josh
 Poimboeuf <jpoimboe@redhat.com>, jsperbeck@google.com, julia@ni.com,
 kamalesh@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 leoyang.li@nxp.com, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ram Pai <linuxram@us.ibm.com>, maddy@linux.vnet.ibm.com,
 mahesh@linux.vnet.ibm.com, Mathieu Malaterre <malat@debian.org>,
 mwb@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, Nick Piggin <npiggin@gmail.com>,
 oss@buserror.net, Paul Mackerras <paulus@ozlabs.org>, Rob Herring
 <robh@kernel.org>, ruscur@russell.cc, santosh@fossix.org, Andreas Schwab
 <schwab@linux-m68k.org>, Stewart Smith <stewart@linux.vnet.ibm.com>,
 sukadev@linux.vnet.ibm.com, Tejun Heo <tj@kernel.org>,
 wei.guo.simon@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.16-1 tag
In-Reply-To: <CA+55aFypU331cQy-6ZJ6szF=2KVLqcbwCUGd+gTwPViRqRWN+g@mail.gmail.com>
References: <87y3kbpkxy.fsf@concordia.ellerman.id.au> <CA+55aFypU331cQy-6ZJ6szF=2KVLqcbwCUGd+gTwPViRqRWN+g@mail.gmail.com>
Date: Wed, 07 Feb 2018 00:39:53 +1100
Message-ID: <87mv0mw82e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591296862282099006?=
X-GMAIL-MSGID: =?utf-8?q?1591659093961944441?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:
> Hmm. This adds a
>
>    static inline void pci_uevent_ers(struct pci_dev *pdev, ..
>
> to include/linux/pci.h.
>
> Why?
>
> You do realize that that header file is included by almost every
> driver out there. Why is that magical function *so* important that it
> needs to be an inline function, and those strings etc duplicated in
> every user?
>
> Yes, that header file is already full of random inline functions, but
> they are generally wrapper functions that don't really do anything,
> and in many cases ithey are also basically configurable to really do
> nothing at all so that the compiler can remove all trace of something
> that isn't enabled.
>
> This function, in contrast, is simply not that at all. I see literally
> _zero_ reason why it should be an inline in a really core file.
>
> It's not important.
>
> It's not performance critical.
>
> It's not even used by any core drivers.

All true.

> I pulled this, but honestly, this part was *GARBAGE*. I'm used to
> people always thinking that *their* code is so important that it needs
> to be front and center, but this is just ridiculous shit.

I disagree. This was just a relatively new contributor looking for somewhere to
put a function so that it could be shared between powerpc code and the PCI AER
code, and choosing the easy but wrong option.

None of us think this code is important, we're not trying to put it "front and
center", there just isn't an obvious home for this function in an existing .c
file that doesn't cause it to be built in when it's not needed.

And yeah I should have caught it in review, so I have no problem with you being
annoyed about *that*.

Anyway I'll talk to Bjorn and find a better place for it.

cheers

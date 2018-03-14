Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1630703-1521029080-2-749857789651271418
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521029079; b=TOauesi5PRHbeAHS+jT9MUIfNMBvGf0zT2jf5iouz51YxEA
    A/FFGjwoh6sfRPs7p/UoBecZB4UobDWOSA5JJBi6xiYSHhhOBlDlVchN7GSUA2+n
    cUSi+GrVn9IQ3F9+9OkaN0FBSTQv5BRTBO7heUqJLvSlE1x5BOB8A6qpJcoW6j8z
    lJH16+WZOscRUFdGW8p5fYC43kseWI63CPTUZBp2TebafnPOPRWjeLV95XQtmSn7
    CsOevgKGk72J8KYfEbJ+10HCR1uJi4H6L0/e2KJQraYbTS/E0Oneo9naDBM5fCx8
    9walEI09ygNd1H3RNb54KUM+ek0yHgXvLRuMwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521029079; bh=2
    uUVDdB70r5AHpQwSyXnUEriHn1I6EhQHa2G8Rg55nc=; b=jeSbuirNn1OHPbRnn
    XfDR7fXuXGKfA1zrOJFhrxBQPUbz5bt9apVcW7Ts+CM9DjquFihSbyoUgNW0e2Ao
    a7q7cmTaoCA7k8Br2LHHsY1/sFkbUxCyr/liOOZFoEXNnHMaDWRRR8MUCSwe5t2R
    tE8qPcvCDQiZZDJFlnrNRl21N2wXg1YQf97AJ5vnclOJokatJv48OFt93ec5Z8Ci
    54iBHFMHa+7VKsNSTU3SWRFkIw6C2GkiXTEew2fyyZ1jm5RlzseSOJirgW4ABAlH
    7RhCQk4Q7OQakuL43skDt+v1uTTJrT9wmtvnqH8SpIB7e96vzLKPVSKygp/Jyi4N
    57JKA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 14 Mar 2018 13:04:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Subject: Re: [PATCH] staging: ccree: remove ccree staging copy
Message-ID: <20180314120431.GA31091@kroah.com>
References: <1520498678-32175-1-git-send-email-gilad@benyossef.com>
 <20180308171409.GA21632@kroah.com>
 <CAOtvUMfSd4k_sDcn7pDY_r_pOqx8C9dTkK=nhkqQSuGYDjmAaA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOtvUMfSd4k_sDcn7pDY_r_pOqx8C9dTkK=nhkqQSuGYDjmAaA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Ofir Drang <ofir.drang@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 05:56:57AM -0700, Gilad Ben-Yossef wrote:
> On Thu, Mar 8, 2018 at 9:14 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Thu, Mar 08, 2018 at 08:44:38AM +0000, Gilad Ben-Yossef wrote:
> >> Now when the ccree driver has been accepted into the cryptodev tree
> >> we can remove the staging tree copy.
> >
> > Yeah!  Nice job.
> >
> >>
> >> Please note that this commit may cause a merge conflict with the
> >> cryptodev tree since we needed to disable the staging copy in order
> >> to get the new copy to compile but the resolution is trivial.
> >>
> >> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> >> ---
> >>  drivers/staging/Kconfig                  |    2 -
> >>  drivers/staging/Makefile                 |    1 -
> >>  drivers/staging/ccree/Kconfig            |   27 -
> >>  drivers/staging/ccree/Makefile           |    7 -
> >>  drivers/staging/ccree/TODO               |   10 -
> >>  drivers/staging/ccree/cc_aead.c          | 2704 ------------------------------
> >>  drivers/staging/ccree/cc_aead.h          |  109 --
> >>  drivers/staging/ccree/cc_buffer_mgr.c    | 1651 ------------------
> >>  drivers/staging/ccree/cc_buffer_mgr.h    |   74 -
> >>  drivers/staging/ccree/cc_cipher.c        | 1165 -------------
> >>  drivers/staging/ccree/cc_cipher.h        |   74 -
> >>  drivers/staging/ccree/cc_crypto_ctx.h    |  170 --
> >>  drivers/staging/ccree/cc_debugfs.c       |  101 --
> >>  drivers/staging/ccree/cc_debugfs.h       |   32 -
> >>  drivers/staging/ccree/cc_driver.c        |  474 ------
> >>  drivers/staging/ccree/cc_driver.h        |  194 ---
> >>  drivers/staging/ccree/cc_fips.c          |  111 --
> >>  drivers/staging/ccree/cc_fips.h          |   37 -
> >>  drivers/staging/ccree/cc_hash.c          | 2296 -------------------------
> >>  drivers/staging/ccree/cc_hash.h          |  114 --
> >>  drivers/staging/ccree/cc_host_regs.h     |  142 --
> >>  drivers/staging/ccree/cc_hw_queue_defs.h |  590 -------
> >>  drivers/staging/ccree/cc_ivgen.c         |  280 ----
> >>  drivers/staging/ccree/cc_ivgen.h         |   55 -
> >>  drivers/staging/ccree/cc_kernel_regs.h   |  167 --
> >>  drivers/staging/ccree/cc_lli_defs.h      |   59 -
> >>  drivers/staging/ccree/cc_pm.c            |  122 --
> >>  drivers/staging/ccree/cc_pm.h            |   57 -
> >>  drivers/staging/ccree/cc_request_mgr.c   |  713 --------
> >>  drivers/staging/ccree/cc_request_mgr.h   |   51 -
> >>  drivers/staging/ccree/cc_sram_mgr.c      |  107 --
> >>  drivers/staging/ccree/cc_sram_mgr.h      |   65 -
> >>  32 files changed, 11761 deletions(-)
> >>  delete mode 100644 drivers/staging/ccree/Kconfig
> >>  delete mode 100644 drivers/staging/ccree/Makefile
> >>  delete mode 100644 drivers/staging/ccree/TODO
> >>  delete mode 100644 drivers/staging/ccree/cc_aead.c
> >>  delete mode 100644 drivers/staging/ccree/cc_aead.h
> >>  delete mode 100644 drivers/staging/ccree/cc_buffer_mgr.c
> >>  delete mode 100644 drivers/staging/ccree/cc_buffer_mgr.h
> >>  delete mode 100644 drivers/staging/ccree/cc_cipher.c
> >>  delete mode 100644 drivers/staging/ccree/cc_cipher.h
> >>  delete mode 100644 drivers/staging/ccree/cc_crypto_ctx.h
> >>  delete mode 100644 drivers/staging/ccree/cc_debugfs.c
> >>  delete mode 100644 drivers/staging/ccree/cc_debugfs.h
> >>  delete mode 100644 drivers/staging/ccree/cc_driver.c
> >>  delete mode 100644 drivers/staging/ccree/cc_driver.h
> >>  delete mode 100644 drivers/staging/ccree/cc_fips.c
> >>  delete mode 100644 drivers/staging/ccree/cc_fips.h
> >>  delete mode 100644 drivers/staging/ccree/cc_hash.c
> >>  delete mode 100644 drivers/staging/ccree/cc_hash.h
> >>  delete mode 100644 drivers/staging/ccree/cc_host_regs.h
> >>  delete mode 100644 drivers/staging/ccree/cc_hw_queue_defs.h
> >>  delete mode 100644 drivers/staging/ccree/cc_ivgen.c
> >>  delete mode 100644 drivers/staging/ccree/cc_ivgen.h
> >>  delete mode 100644 drivers/staging/ccree/cc_kernel_regs.h
> >>  delete mode 100644 drivers/staging/ccree/cc_lli_defs.h
> >>  delete mode 100644 drivers/staging/ccree/cc_pm.c
> >>  delete mode 100644 drivers/staging/ccree/cc_pm.h
> >>  delete mode 100644 drivers/staging/ccree/cc_request_mgr.c
> >>  delete mode 100644 drivers/staging/ccree/cc_request_mgr.h
> >>  delete mode 100644 drivers/staging/ccree/cc_sram_mgr.c
> >>  delete mode 100644 drivers/staging/ccree/cc_sram_mgr.h
> >>
> >> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> >> index e95ab68..7802c26 100644
> >> --- a/drivers/staging/Kconfig
> >> +++ b/drivers/staging/Kconfig
> >> @@ -114,8 +114,6 @@ source "drivers/staging/greybus/Kconfig"
> >>
> >>  source "drivers/staging/vc04_services/Kconfig"
> >>
> >> -source "drivers/staging/ccree/Kconfig"
> >> -
> >>  source "drivers/staging/typec/Kconfig"
> >>
> >>  source "drivers/staging/vboxvideo/Kconfig"
> >> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> >> index af8cd6a..56afa21 100644
> >> --- a/drivers/staging/Makefile
> >> +++ b/drivers/staging/Makefile
> >> @@ -49,6 +49,5 @@ obj-$(CONFIG_MOST)          += most/
> >>  obj-$(CONFIG_KS7010)         += ks7010/
> >>  obj-$(CONFIG_GREYBUS)                += greybus/
> >>  obj-$(CONFIG_BCM2835_VCHIQ)  += vc04_services/
> >> -obj-$(CONFIG_CRYPTO_DEV_CCREE)       += ccree/
> >>  obj-$(CONFIG_DRM_VBOXVIDEO)  += vboxvideo/
> >>  obj-$(CONFIG_PI433)          += pi433/
> >> diff --git a/drivers/staging/ccree/Kconfig b/drivers/staging/ccree/Kconfig
> >> deleted file mode 100644
> >> index c94dfe8..0000000
> >
> > This patch doesn't apply at all.  Does it work for you when using 'git
> > am' to import it?
> 
> Sorry, my bad. I tried to save the mailing list a patch of 12k lines
> of code of just deleting stuff so I've used the git-format -D option.
> 
> Apparently that is not how this is done.
> 
> >
> > Should I just do this "by hand" instead?
> >
> 
> Yes please.

Now done, again, nice work.

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

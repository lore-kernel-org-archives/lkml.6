Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136BDC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5872204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wmBV79AA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5872204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeJTWCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbeJTWCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:02:32 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08CBB2152D;
        Sat, 20 Oct 2018 13:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540043518;
        bh=FG4MEst2oO1UbrejGsyiG4XbQcvgSwdjI5wpcGSG0Bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wmBV79AA9qb2dhaotzoGniU6//Ww+CSU8o79lEJEQ5ixd+z+KHEcxfF1QuZQnfzbh
         6+tFHC+WTlTOqhLu40hPeYcN4YMGB7LMk8fIHC7TltTFwgM+B5LkfgOmZerL0y2CB8
         KWnSYGJTyCj3O1sEaZO7DEmkVvwQ7LOIhcmhG5IU=
Date:   Sat, 20 Oct 2018 15:50:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>
Subject: [PATCH 2/7] Code of Conduct Interpretation: Add document explaining
 how the Code of Conduct is to be interpreted
Message-ID: <20181020135000.GC32218@kroah.com>
References: <20181020134908.GA32218@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181020134908.GA32218@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Contributor Covenant Code of Conduct is a general document meant to
provide a set of rules for almost any open source community.  Every
open-source community is unique and the Linux kernel is no exception.
Because of this, this document describes how we in the Linux kernel
community will interpret it.  We also do not expect this interpretation
to be static over time, and will adjust it as needed.

This document was created with the input and feedback of the TAB as well
as many current kernel maintainers.

Co-Developed-by: Thomas Gleixner <tglx@linutronix.de>
Co-Developed-by: Olof Johansson <olof@lixom.net>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
Acked-by: Borislav Petkov <bp@kernel.org>
Acked-by: Chris Mason <clm@fb.com>
Acked-by: Christian Lütke-Stetzkamp <christian@lkamp.de>
Acked-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Acked-by: Dave Airlie <airlied@redhat.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: David Ahern <dsa@cumulusnetworks.com>
Acked-by: David Sterba <kdave@kernel.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Eric Dumazet <eric.dumazet@gmail.com>
Acked-by: Felipe Balbi <balbi@kernel.org>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Hans Verkuil <hverkuil@xs4all.nl>
Acked-by: Hans de Goede <j.w.r.degoede@gmail.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>
Acked-by: James Smart <james.smart@broadcom.com>
Acked-by: James Smart <jsmart2021@gmail.com>
Acked-by: Jan Kara <jack@ucw.cz>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Acked-by: Jens Axboe <axboe@kernel.dk>
Acked-by: Jessica Yu <jeyu@kernel.org>
Acked-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Acked-by: Jiri Kosina <jikos@kernel.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Joerg Roedel <joro@8bytes.org>
Acked-by: Johan Hovold <johan@kernel.org>
Acked-by: Johannes Thumshirn <jth@kernel.org>
Acked-by: Jonathan Corbet <corbet@lwn.net>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Lina Iyer <ilina@codeaurora.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Matias Bjørling <mb@lightnvm.io>
Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Mishi Choudhary <mishi@linux.com>
Acked-by: Nikolay Borisov <n.borisov.lkml@gmail.com>
Acked-by: Oded Gabbay <oded.gabbay@gmail.com>
Acked-by: Palmer Dabbelt <palmer@dabbelt.com>
Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Richard Weinberger <richard@nod.at>
Acked-by: Rik van Riel <riel@surriel.com>
Acked-by: Rob Clark <robdclark@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Acked-by: Sean Paul <sean@poorly.run>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Sebastian Reichel <sre@kernel.org>
Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
Acked-by: Shuah Khan <shuah@kernel.org>
Acked-by: Simon Horman <horms@verge.net.au>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Takashi Iwai <tiwai@kernel.org>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Todd Poynor <toddpoynor@google.com>
Acked-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../code-of-conduct-interpretation.rst        | 153 ++++++++++++++++++
 Documentation/process/index.rst               |   1 +
 2 files changed, 154 insertions(+)
 create mode 100644 Documentation/process/code-of-conduct-interpretation.rst

diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
new file mode 100644
index 000000000000..b14441711f7b
--- /dev/null
+++ b/Documentation/process/code-of-conduct-interpretation.rst
@@ -0,0 +1,153 @@
+Linux Kernel Contributor Covenant Code of Conduct Interpretation
+================================================================
+
+The Contributor Covenant Code of Conduct is a general document meant to
+provide a set of rules for almost any open source community.  Every
+open-source community is unique and the Linux kernel is no exception.
+Because of this, this document describes how we in the Linux kernel
+community will interpret it.  We also do not expect this interpretation
+to be static over time, and will adjust it as needed.
+
+The Linux kernel development effort is a very personal process compared
+to "traditional" ways of developing software.  Your contributions and
+ideas behind them will be carefully reviewed, often resulting in
+critique and criticism.  The review will almost always require
+improvements before the material can be included in the
+kernel.  Know that this happens because everyone involved wants to see
+the best possible solution for the overall success of Linux.  This
+development process has been proven to create the most robust operating
+system kernel ever, and we do not want to do anything to cause the
+quality of submission and eventual result to ever decrease.
+
+Maintainers
+-----------
+
+The Code of Conduct uses the term "maintainers" numerous times.  In the
+kernel community, a "maintainer" is anyone who is responsible for a
+subsystem, driver, or file, and is listed in the MAINTAINERS file in the
+kernel source tree.
+
+Responsibilities
+----------------
+
+The Code of Conduct mentions rights and responsibilities for
+maintainers, and this needs some further clarifications.
+
+First and foremost, it is a reasonable expectation to have maintainers
+lead by example.
+
+That being said, our community is vast and broad, and there is no new
+requirement for maintainers to unilaterally handle how other people
+behave in the parts of the community where they are active.  That
+responsibility is upon all of us, and ultimately the Code of Conduct
+documents final escalation paths in case of unresolved concerns
+regarding conduct issues.
+
+Maintainers should be willing to help when problems occur, and work with
+others in the community when needed.  Do not be afraid to reach out to
+the TAB or other maintainers if you're uncertain how to handle
+situations that come up.  It will not be considered a violation report
+unless you want it to be.  If you are uncertain about approaching the
+TAB or any other maintainers, please reach out to our conflict mediator,
+Mishi Choudhary <mishi@linux.com>.
+
+In the end, "be kind to each other" is really what the end goal is for
+everybody.  We know everyone is human and we all fail at times, but the
+primary goal for all of us should be to work toward amicable resolutions
+of problems.  Enforcement of the code of conduct will only be a last
+resort option.
+
+Our goal of creating a robust and technically advanced operating system
+and the technical complexity involved naturally require expertise and
+decision-making.
+
+The required expertise varies depending on the area of contribution.  It
+is determined mainly by context and technical complexity and only
+secondary by the expectations of contributors and maintainers.
+
+Both the expertise expectations and decision-making are subject to
+discussion, but at the very end there is a basic necessity to be able to
+make decisions in order to make progress.  This prerogative is in the
+hands of maintainers and project's leadership and is expected to be used
+in good faith.
+
+As a consequence, setting expertise expectations, making decisions and
+rejecting unsuitable contributions are not viewed as a violation of the
+Code of Conduct.
+
+While maintainers are in general welcoming to newcomers, their capacity
+of helping contributors overcome the entry hurdles is limited, so they
+have to set priorities.  This, also, is not to be seen as a violation of
+the Code of Conduct.  The kernel community is aware of that and provides
+entry level programs in various forms like kernelnewbies.org.
+
+Scope
+-----
+
+The Linux kernel community primarily interacts on a set of public email
+lists distributed around a number of different servers controlled by a
+number of different companies or individuals.  All of these lists are
+defined in the MAINTAINERS file in the kernel source tree.  Any emails
+sent to those mailing lists are considered covered by the Code of
+Conduct.
+
+Developers who use the kernel.org bugzilla, and other subsystem bugzilla
+or bug tracking tools should follow the guidelines of the Code of
+Conduct.  The Linux kernel community does not have an "official" project
+email address, or "official" social media address.  Any activity
+performed using a kernel.org email account must follow the Code of
+Conduct as published for kernel.org, just as any individual using a
+corporate email account must follow the specific rules of that
+corporation.
+
+The Code of Conduct does not prohibit continuing to include names, email
+addresses, and associated comments in mailing list messages, kernel
+change log messages, or code comments.
+
+Interaction in other forums is covered by whatever rules apply to said
+forums and is in general not covered by the Code of Conduct.  Exceptions
+may be considered for extreme circumstances.
+
+Contributions submitted for the kernel should use appropriate language.
+Content that already exists predating the Code of Conduct will not be
+addressed now as a violation.  Inappropriate language can be seen as a
+bug, though; such bugs will be fixed more quickly if any interested
+parties submit patches to that effect.  Expressions that are currently
+part of the user/kernel API, or reflect terminology used in published
+standards or specifications, are not considered bugs.
+
+Enforcement
+-----------
+
+The address listed in the Code of Conduct goes to the Code of Conduct
+Committee.  The exact members receiving these emails at any given time
+are listed at <URL>.  Members can not access reports made before they
+joined or after they have left the committee.
+
+The initial Code of Conduct Committee consists of volunteer members of
+the Technical Advisory Board (TAB), as well as a professional mediator
+acting as a neutral third party.  The first task of the committee is to
+establish documented processes, which will be made public.
+
+Any member of the committee, including the mediator, can be contacted
+directly if a reporter does not wish to include the full committee in a
+complaint or concern.
+
+The Code of Conduct Committee reviews the cases according to the
+processes (see above) and consults with the TAB as needed and
+appropriate, for instance to request and receive information about the
+kernel community.
+
+Any decisions by the committee will be brought to the TAB, for
+implementation of enforcement with the relevant maintainers if needed.
+A decision by the Code of Conduct Committee can be overturned by the TAB
+by a two-thirds vote.
+
+At quarterly intervals, the Code of Conduct Committee and TAB will
+provide a report summarizing the anonymised reports that the Code of
+Conduct committee has received and their status, as well details of any
+overridden decisions including complete and identifiable voting details.
+
+We expect to establish a different process for Code of Conduct Committee
+staffing beyond the bootstrap period.  This document will be updated
+with that information when this occurs.
diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index 9ae3e317bddf..42691e2880eb 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -21,6 +21,7 @@ Below are the essential guides that every developer should read.
 
    howto
    code-of-conduct
+   code-of-conduct-interpretation
    development-process
    submitting-patches
    coding-style
-- 
2.19.1


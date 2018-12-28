Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C863C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFC42146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733265AbeL1QGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:06:25 -0500
Received: from ms.lwn.net ([45.79.88.28]:42212 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbeL1QGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:06:25 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CAB4697E;
        Fri, 28 Dec 2018 16:06:23 +0000 (UTC)
Date:   Fri, 28 Dec 2018 09:06:22 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 5.0
Message-ID: <20181228090622.4c210228@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-5.0

for you to fetch changes up to 942104a21ce4951420ddf6c6b3179a0627301f7e:

  docs: improve pathname-lookup document structure (2018-12-20 08:47:18 -0700)

----------------------------------------------------------------
A fairly normal cycle for documentation stuff.  We have a new
document on perf security, more Italian translations, more
improvements to the memory-management docs, improvements to the
pathname lookup documentation, and the usual array of smaller
fixes.

As is often the case, there are a few reaches outside of
Documentation/ to adjust kerneldoc comments.

Expect a trivial merge conflict with the fscrypt tree; the resolution
is to just take both sides.
----------------------------------------------------------------
Alexey Budankov (2):
      Documentation/admin-guide: introduce perf-security.rst file
      Documentation/admin-guide: update admin-guide index.rst

Amir Livneh (1):
      doc: tracing: Fix a number of typos

Andrzej Bednarski (1):
      Correct gen_init_cpio tool's documentation

Andy Shevchenko (1):
      dmaengine: Add mailing list address to the documentation

Christoph Niedermaier (2):
      Docs/EDID: Fixed erroneous bits of XOFFSET, XPULSE, YOFFSET and YPULSE
      Docs/EDID: Calculate CRC while building the code

Colin Ian King (1):
      Documentation: fix spelling mistake, EACCESS -> EACCES

Daniel Colascione (1):
      Document /proc/pid PID reuse behavior

Federico Vaga (6):
      doc:it_IT: add some process/* translations
      doc:it_IT: fix locking.rst section title
      doc:it_IT:doc-guide: fix reference to foobar
      doc:it: fixes in process/1.Intro
      doc:it: add some process/* translations
      doc:process: add links where missing

Geert Uytterhoeven (1):
      Documentation/ras: Typo s/use use/use/

Helen Koike (1):
      configfs: fix wrong name of struct in documentation

Jonathan Corbet (1):
      Merge branch 'kmalloc' into docs-next

Joris Gutjahr (1):
      doc-guide:kernel-doc.rst: Reference to foobar

Matthew Wilcox (1):
      Link the memory allocation guide from the MM docs

Michael S. Tsirkin (1):
      x86, boot: documentation whitespace fixup

Mike Rapoport (7):
      kernel-doc: kill trailing whitespace
      kernel-doc: extend $type_param to match members referenced by pointer
      docs/mm: update kmalloc kernel-doc description
      docs/admin-guide/mm/concepts.rst: grammar and style fixups
      docs/core-api: make mm-api.rst more structured
      slab: make kmem_cache_create{_usercopy} description proper kernel-doc
      docs/mm-api: link slab_common.c to "The Slab Cache" section

NeilBrown (3):
      Documentation: update path-lookup.md for parallel lookups
      Documentation: convert path-lookup from markdown to resturctured text
      docs: improve pathname-lookup document structure

Nicholas Mc Guire (1):
      Documentation: devres: note checking needs when converting

Randy Dunlap (3):
      Documentation: dynamic_debug: fix a couple of typos
      Documentation: dynamic-debug: fix wildcard description
      Documentation/dev-tools: clean up kselftest.rst

Sakari Ailus (1):
      scripts/kernel-doc: Fix struct and struct field attribute processing

Shreyans Devendra Doshi (1):
      Documentation: dev-tools: Fix typos in index.rst

Waiman Long (1):
      Documentation/proc.txt: Add 2 missing fields for /proc/<pid>/status

Will Deacon (1):
      Documentation: Use "while" instead of "whilst"

 Documentation/EDID/1024x768.S                      |    5 +-
 Documentation/EDID/1280x1024.S                     |    5 +-
 Documentation/EDID/1600x1200.S                     |    5 +-
 Documentation/EDID/1680x1050.S                     |    5 +-
 Documentation/EDID/1920x1080.S                     |    5 +-
 Documentation/EDID/800x600.S                       |    5 +-
 Documentation/EDID/HOWTO.txt                       |   13 +-
 Documentation/EDID/Makefile                        |   15 +-
 Documentation/EDID/edid.S                          |   10 +-
 Documentation/admin-guide/devices.rst              |    1 +
 Documentation/admin-guide/dynamic-debug-howto.rst  |    8 +-
 Documentation/admin-guide/index.rst                |    1 +
 Documentation/admin-guide/kernel-parameters.txt    |    2 +-
 Documentation/admin-guide/mm/concepts.rst          |   51 +-
 Documentation/admin-guide/perf-security.rst        |   97 ++
 Documentation/admin-guide/ras.rst                  |    2 +-
 Documentation/admin-guide/security-bugs.rst        |    2 +-
 Documentation/arm/Booting                          |    2 +-
 Documentation/arm/Samsung-S3C24XX/GPIO.txt         |    2 +-
 Documentation/arm/Samsung-S3C24XX/Overview.txt     |    2 +-
 Documentation/arm/Samsung-S3C24XX/Suspend.txt      |    2 +-
 Documentation/core-api/assoc_array.rst             |    6 +-
 Documentation/core-api/memory-allocation.rst       |    2 +
 Documentation/core-api/mm-api.rst                  |   32 +-
 Documentation/dev-tools/coccinelle.rst             |    2 +
 Documentation/dev-tools/index.rst                  |    4 +-
 Documentation/dev-tools/kselftest.rst              |   12 +-
 Documentation/device-mapper/dm-raid.txt            |    2 +-
 .../devicetree/bindings/arm/idle-states.txt        |    2 +-
 .../devicetree/bindings/pci/host-generic-pci.txt   |    2 +-
 Documentation/devicetree/bindings/serial/rs485.txt |    2 +-
 Documentation/doc-guide/kernel-doc.rst             |    2 +-
 Documentation/doc-guide/sphinx.rst                 |    2 +
 Documentation/driver-api/dmaengine/dmatest.rst     |    4 +
 Documentation/driver-api/pm/devices.rst            |    2 +
 Documentation/driver-model/devres.txt              |    7 +
 Documentation/early-userspace/README               |    2 +-
 Documentation/filesystems/caching/backend-api.txt  |    2 +-
 Documentation/filesystems/caching/cachefiles.txt   |    4 +-
 Documentation/filesystems/caching/netfs-api.txt    |    2 +-
 Documentation/filesystems/caching/operations.txt   |    2 +-
 Documentation/filesystems/configfs/configfs.txt    |    2 +-
 Documentation/filesystems/index.rst                |   21 +
 .../{path-lookup.md => path-lookup.rst}            |  913 ++++++++--------
 Documentation/filesystems/proc.txt                 |   13 +-
 Documentation/filesystems/qnx6.txt                 |    4 +-
 Documentation/filesystems/spufs.txt                |    2 +-
 Documentation/filesystems/vfs.txt                  |    2 +-
 .../filesystems/xfs-self-describing-metadata.txt   |    2 +-
 Documentation/filesystems/xfs.txt                  |    2 +-
 Documentation/gpu/drm-uapi.rst                     |    4 +-
 Documentation/leds/leds-class.txt                  |    2 +-
 Documentation/media/uapi/v4l/extended-controls.rst |    2 +-
 Documentation/memory-barriers.txt                  |   22 +-
 Documentation/networking/de4x5.txt                 |    2 +-
 Documentation/networking/rxrpc.txt                 |   10 +-
 Documentation/power/regulator/overview.txt         |    2 +-
 Documentation/process/1.Intro.rst                  |    2 +
 Documentation/process/4.Coding.rst                 |    3 +-
 Documentation/process/5.Posting.rst                |   23 +-
 Documentation/process/8.Conclusion.rst             |    7 +-
 Documentation/process/adding-syscalls.rst          |    3 +
 Documentation/process/changes.rst                  |    2 +-
 Documentation/process/coding-style.rst             |    2 +-
 Documentation/process/howto.rst                    |   13 +-
 Documentation/process/kernel-driver-statement.rst  |    2 +
 .../process/kernel-enforcement-statement.rst       |    4 +-
 Documentation/process/magic-number.rst             |    2 +
 Documentation/process/management-style.rst         |    5 +-
 Documentation/process/submitting-drivers.rst       |    8 +-
 Documentation/s390/3270.ChangeLog                  |    2 +-
 Documentation/security/credentials.rst             |    8 +-
 Documentation/security/keys/request-key.rst        |    2 +-
 Documentation/serial/serial-rs485.txt              |    2 +-
 Documentation/sound/soc/dai.rst                    |    6 +-
 Documentation/sound/soc/dpcm.rst                   |    2 +-
 Documentation/static-keys.txt                      |    2 +-
 Documentation/thermal/power_allocator.txt          |    2 +-
 Documentation/trace/ftrace.rst                     |   14 +-
 .../translations/it_IT/admin-guide/README.rst      |   12 +
 .../it_IT/admin-guide/security-bugs.rst            |   12 +
 .../translations/it_IT/doc-guide/kernel-doc.rst    |    2 +-
 Documentation/translations/it_IT/index.rst         |    1 +
 .../translations/it_IT/kernel-hacking/locking.rst  |    4 +-
 .../translations/it_IT/process/1.Intro.rst         |  297 ++++++
 .../translations/it_IT/process/2.Process.rst       |  531 ++++++++++
 .../translations/it_IT/process/3.Early-stage.rst   |  241 +++++
 .../translations/it_IT/process/4.Coding.rst        |  447 ++++++++
 .../translations/it_IT/process/5.Posting.rst       |  348 +++++++
 .../translations/it_IT/process/6.Followthrough.rst |  240 +++++
 .../it_IT/process/7.AdvancedTopics.rst             |  191 ++++
 .../translations/it_IT/process/8.Conclusion.rst    |   85 ++
 .../translations/it_IT/process/adding-syscalls.rst |  643 ++++++++++++
 .../it_IT/process/applying-patches.rst             |   13 +
 .../translations/it_IT/process/changes.rst         |   12 +
 .../translations/it_IT/process/clang-format.rst    |  197 ++++
 .../translations/it_IT/process/code-of-conduct.rst |   12 +
 .../translations/it_IT/process/coding-style.rst    | 1094 ++++++++++++++++++++
 .../it_IT/process/development-process.rst          |   33 +
 .../translations/it_IT/process/email-clients.rst   |   12 +
 Documentation/translations/it_IT/process/howto.rst |  655 ++++++++++++
 Documentation/translations/it_IT/process/index.rst |   67 ++
 .../translations/it_IT/process/kernel-docs.rst     |   13 +
 .../it_IT/process/kernel-driver-statement.rst      |  211 ++++
 .../it_IT/process/kernel-enforcement-statement.rst |   13 +
 .../translations/it_IT/process/magic-number.rst    |  170 +++
 .../it_IT/process/maintainer-pgp-guide.rst         |   13 +
 .../it_IT/process/management-style.rst             |   12 +
 .../it_IT/process/stable-api-nonsense.rst          |   13 +
 .../it_IT/process/stable-kernel-rules.rst          |   12 +
 .../it_IT/process/submit-checklist.rst             |   12 +
 .../it_IT/process/submitting-drivers.rst           |   12 +
 .../it_IT/process/submitting-patches.rst           |   13 +
 .../it_IT/process/volatile-considered-harmful.rst  |  134 +++
 Documentation/vm/index.rst                         |    4 +-
 Documentation/x86/boot.txt                         |    2 +-
 include/linux/slab.h                               |   55 +-
 mm/slab_common.c                                   |   35 +-
 scripts/kernel-doc                                 |   13 +-
 119 files changed, 6688 insertions(+), 654 deletions(-)
 create mode 100644 Documentation/admin-guide/perf-security.rst
 rename Documentation/filesystems/{path-lookup.md => path-lookup.rst} (56%)
 create mode 100644 Documentation/translations/it_IT/admin-guide/README.rst
 create mode 100644 Documentation/translations/it_IT/admin-guide/security-bugs.rst
 create mode 100644 Documentation/translations/it_IT/process/1.Intro.rst
 create mode 100644 Documentation/translations/it_IT/process/2.Process.rst
 create mode 100644 Documentation/translations/it_IT/process/3.Early-stage.rst
 create mode 100644 Documentation/translations/it_IT/process/4.Coding.rst
 create mode 100644 Documentation/translations/it_IT/process/5.Posting.rst
 create mode 100644 Documentation/translations/it_IT/process/6.Followthrough.rst
 create mode 100644 Documentation/translations/it_IT/process/7.AdvancedTopics.rst
 create mode 100644 Documentation/translations/it_IT/process/8.Conclusion.rst
 create mode 100644 Documentation/translations/it_IT/process/adding-syscalls.rst
 create mode 100644 Documentation/translations/it_IT/process/applying-patches.rst
 create mode 100644 Documentation/translations/it_IT/process/changes.rst
 create mode 100644 Documentation/translations/it_IT/process/clang-format.rst
 create mode 100644 Documentation/translations/it_IT/process/code-of-conduct.rst
 create mode 100644 Documentation/translations/it_IT/process/coding-style.rst
 create mode 100644 Documentation/translations/it_IT/process/development-process.rst
 create mode 100644 Documentation/translations/it_IT/process/email-clients.rst
 create mode 100644 Documentation/translations/it_IT/process/howto.rst
 create mode 100644 Documentation/translations/it_IT/process/index.rst
 create mode 100644 Documentation/translations/it_IT/process/kernel-docs.rst
 create mode 100644 Documentation/translations/it_IT/process/kernel-driver-statement.rst
 create mode 100644 Documentation/translations/it_IT/process/kernel-enforcement-statement.rst
 create mode 100644 Documentation/translations/it_IT/process/magic-number.rst
 create mode 100644 Documentation/translations/it_IT/process/maintainer-pgp-guide.rst
 create mode 100644 Documentation/translations/it_IT/process/management-style.rst
 create mode 100644 Documentation/translations/it_IT/process/stable-api-nonsense.rst
 create mode 100644 Documentation/translations/it_IT/process/stable-kernel-rules.rst
 create mode 100644 Documentation/translations/it_IT/process/submit-checklist.rst
 create mode 100644 Documentation/translations/it_IT/process/submitting-drivers.rst
 create mode 100644 Documentation/translations/it_IT/process/submitting-patches.rst
 create mode 100644 Documentation/translations/it_IT/process/volatile-considered-harmful.rst

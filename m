Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBDDC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654282082F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 08:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfBCIQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 03:16:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:22275 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfBCIQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 03:16:33 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2019 00:16:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,555,1539673200"; 
   d="xz'?yaml'?scan'208";a="119607507"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.107])
  by fmsmga007.fm.intel.com with ESMTP; 03 Feb 2019 00:16:14 -0800
Date:   Sun, 3 Feb 2019 16:16:35 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc:     0day robot <lkp@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Dmitry Rogozhkin <dmitry.v.rogozhkin@intel.com>,
        Zhipeng Gong <zhipeng.gong@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tony Ye <tony.ye@intel.com>,
        Timo Aaltonen <timo.aaltonen@canonical.com>,
        Takashi Iwai <tiwai@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: [LKP] [drm/i915]  cf3a71f2fb:
 piglit.igt.gem_ctx_param.invalid-param-get.fail
Message-ID: <20190203081635.GB10498@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

FYI, we noticed the following commit (built with gcc-7):

commit: cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3 ("drm/i915: Expose RPCS (SSEU) configuration to userspace (Gen11 only)")
https://github.com/0day-ci/linux UPDATE-20190201-042817/Tvrtko-Ursulin/Per-context-dynamic-sub-slice-power-gating/20190130-174853

in testcase: piglit
with following parameters:

	group: igt-008

test-description: Piglit is a collection of automated tests for OpenGL implementations.
test-url: https://people.freedesktop.org/~nh/piglit/


on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with 8G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):




igt/gem_pread/basic: ignored_by_lkp
igt/gem_exec_suspend/basic-s3: ignored_by_lkp
igt/gem_exec_suspend/basic-s4: ignored_by_lkp
igt/kms_pipe_crc_basic/read-crc-pipe-b-frame-sequence: ignored_by_lkp
igt/gem_exec_create/basic: ignored_by_lkp
igt/gem_ringfill/basic-default-hang: ignored_by_lkp
igt/kms_flip/basic-flip-vs-wf_vblank: ignored_by_lkp
igt/kms_addfb_basic/addfb25-bad-modifier: ignored_by_lkp
2019-02-03 08:11:25 piglit run igt -t igt.gem_pread.snoop /tmp/lkp/piglit-results -x igt.gem_pread.snoop.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_pread.snoop.seconds: 2.975972718
2019-02-03 08:11:28 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_pread/snoop: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:28 piglit run igt -t igt.gem_ppgtt.flink-and-close-vma-leak /tmp/lkp/piglit-results -x igt.gem_ppgtt.flink-and-close-vma-leak.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_ppgtt.flink-and-close-vma-leak.seconds: 2.799894404
2019-02-03 08:11:31 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_ppgtt/flink-and-close-vma-leak: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:31 piglit run igt -t igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-pri-shrfb-draw-render /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-pri-shrfb-draw-render.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-pri-shrfb-draw-render.seconds: 2.599347761
2019-02-03 08:11:33 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/fbcpsr-2p-primscrn-pri-shrfb-draw-render: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:33 piglit run igt -t igt.prime_mmap.test_refcounting /tmp/lkp/piglit-results -x igt.prime_mmap.test_refcounting.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.prime_mmap.test_refcounting.seconds: 2.756003767
2019-02-03 08:11:36 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/prime_mmap/test_refcounting: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:36 piglit run igt -t igt.gem_userptr_blits.process-exit-gtt-busy /tmp/lkp/piglit-results -x igt.gem_userptr_blits.process-exit-gtt-busy.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_userptr_blits.process-exit-gtt-busy.seconds: 2.655476570
2019-02-03 08:11:39 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_userptr_blits/process-exit-gtt-busy: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:39 piglit run igt -t igt.gem_shrink.execbufn /tmp/lkp/piglit-results -x igt.gem_shrink.execbufn.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_shrink.execbufn.seconds: 3.139317779
2019-02-03 08:11:42 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_shrink/execbufn: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:42 piglit run igt -t igt.kms_flip.2x-flip-vs-panning-vs-hang /tmp/lkp/piglit-results -x igt.kms_flip.2x-flip-vs-panning-vs-hang.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_flip.2x-flip-vs-panning-vs-hang.seconds: 2.807247350
2019-02-03 08:11:45 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_flip/2x-flip-vs-panning-vs-hang: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:45 piglit run igt -t igt.kms_frontbuffer_tracking.psr-rgb101010-draw-blt /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.psr-rgb101010-draw-blt.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.psr-rgb101010-draw-blt.seconds: 2.686419254
2019-02-03 08:11:48 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/psr-rgb101010-draw-blt: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:48 piglit run igt -t igt.gem_exec_whisper.interruptible /tmp/lkp/piglit-results -x igt.gem_exec_whisper.interruptible.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_whisper.interruptible.seconds: 2.770487557
2019-02-03 08:11:51 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_whisper/interruptible: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:51 piglit run igt -t igt.gem_exec_basic.gtt-default /tmp/lkp/piglit-results -x igt.gem_exec_basic.gtt-default.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_basic.gtt-default.seconds: 2.992537692
2019-02-03 08:11:54 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_basic/gtt-default: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:54 piglit run igt -t igt.kms_flip.flip-vs-panning-vs-hang-interruptible /tmp/lkp/piglit-results -x igt.kms_flip.flip-vs-panning-vs-hang-interruptible.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_flip.flip-vs-panning-vs-hang-interruptible.seconds: 99.946972485
2019-02-03 08:13:34 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_flip/flip-vs-panning-vs-hang-interruptible: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:01:39
2019-02-03 08:13:34 piglit run igt -t igt.gem_evict_alignment.major-interruptible /tmp/lkp/piglit-results -x igt.gem_evict_alignment.major-interruptible.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_evict_alignment.major-interruptible.seconds: 2.890800136
2019-02-03 08:13:37 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_evict_alignment/major-interruptible: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:13:37 piglit run igt -t igt.gem_shrink.execbufn-userptr /tmp/lkp/piglit-results -x igt.gem_shrink.execbufn-userptr.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_shrink.execbufn-userptr.seconds: 2.916673143
2019-02-03 08:13:40 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_shrink/execbufn-userptr: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:13:40 piglit run igt -t igt.gem_wait.invalid-buf /tmp/lkp/piglit-results -x igt.gem_wait.invalid-buf.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_wait.invalid-buf.seconds: 2.758484468
2019-02-03 08:13:43 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_wait/invalid-buf: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:13:43 piglit run igt -t igt.gem_shrink.execbuf1 /tmp/lkp/piglit-results -x igt.gem_shrink.execbuf1.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_shrink.execbuf1.seconds: 3.009269350
2019-02-03 08:13:46 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_shrink/execbuf1: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:13:46 piglit run igt -t igt.pm_rc6_residency.media-rc6-accuracy /tmp/lkp/piglit-results -x igt.pm_rc6_residency.media-rc6-accuracy.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.pm_rc6_residency.media-rc6-accuracy.seconds: 2.827380181
2019-02-03 08:13:49 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/pm_rc6_residency/media-rc6-accuracy: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:13:49 piglit run igt -t igt.gem_reset_stats.close-pending-fork-blt /tmp/lkp/piglit-results -x igt.gem_reset_stats.close-pending-fork-blt.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_reset_stats.close-pending-fork-blt.seconds: 18.983046998
2019-02-03 08:14:08 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_reset_stats/close-pending-fork-blt: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:18
2019-02-03 08:14:08 piglit run igt -t igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-cur-indfb-draw-render /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-cur-indfb-draw-render.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-cur-indfb-draw-render.seconds: 2.778737407
2019-02-03 08:14:11 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/fbcpsr-2p-primscrn-cur-indfb-draw-render: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:14:11 piglit run igt -t igt.gem_exec_parallel.default /tmp/lkp/piglit-results -x igt.gem_exec_parallel.default.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_parallel.default.seconds: 2.797506102
2019-02-03 08:14:14 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_parallel/default: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:14:14 piglit run igt -t igt.gem_ring_sync_loop /tmp/lkp/piglit-results -x igt.gem_ring_sync_loop.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_ring_sync_loop.seconds: 2.706546964
2019-02-03 08:14:17 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_ring_sync_loop: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:14:17 piglit run igt -t igt.kms_chv_cursor_fail.pipe-c-64x64-bottom-edge /tmp/lkp/piglit-results -x igt.kms_chv_cursor_fail.pipe-c-64x64-bottom-edge.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_chv_cursor_fail.pipe-c-64x64-bottom-edge.seconds: 5.720606088
2019-02-03 08:14:22 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_chv_cursor_fail/pipe-c-64x64-bottom-edge: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:05
2019-02-03 08:14:23 piglit run igt -t igt.prime_nv_api.nv_self_import_to_different_fd /tmp/lkp/piglit-results -x igt.prime_nv_api.nv_self_import_to_different_fd.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.prime_nv_api.nv_self_import_to_different_fd.seconds: 2.679634197
2019-02-03 08:14:25 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/prime_nv_api/nv_self_import_to_different_fd: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:14:25 piglit run igt -t igt.gem_userptr_blits.input-checking /tmp/lkp/piglit-results -x igt.gem_userptr_blits.input-checking.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_userptr_blits.input-checking.seconds: 2.720751300
2019-02-03 08:14:28 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_userptr_blits/input-checking: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:14:28 piglit run igt -t igt.kms_frontbuffer_tracking.psr-1p-offscren-pri-shrfb-draw-render /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.psr-1p-offscren-pri-shrfb-draw-render.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.psr-1p-offscren-pri-shrfb-draw-render.seconds: 2.523358599
2019-02-03 08:14:31 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/psr-1p-offscren-pri-shrfb-draw-render: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:14:31 piglit run igt -t igt.gem_reset_stats.close-pending-fork-reverse-bsd1 /tmp/lkp/piglit-results -x igt.gem_reset_stats.close-pending-fork-reverse-bsd1.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_reset_stats.close-pending-fork-reverse-bsd1.seconds: 2.738541521
2019-02-03 08:14:34 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_reset_stats/close-pending-fork-reverse-bsd1: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:14:34 piglit run igt -t igt.gem_reset_stats.close-pending-fork-reverse-bsd2 /tmp/lkp/piglit-results -x igt.gem_reset_stats.close-pending-fork-reverse-bsd2.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_reset_stats.close-pending-fork-reverse-bsd2.seconds: 2.714301437
2019-02-03 08:14:36 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_reset_stats/close-pending-fork-reverse-bsd2: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:14:36 piglit run igt -t igt.kms_chv_cursor_fail.pipe-b-64x64-right-edge /tmp/lkp/piglit-results -x igt.kms_chv_cursor_fail.pipe-b-64x64-right-edge.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_chv_cursor_fail.pipe-b-64x64-right-edge.seconds: 5.712827792
2019-02-03 08:14:42 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_chv_cursor_fail/pipe-b-64x64-right-edge: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:05
2019-02-03 08:14:42 piglit run igt -t igt.gem_ringfill.blt-hang /tmp/lkp/piglit-results -x igt.gem_ringfill.blt-hang.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_ringfill.blt-hang.seconds: 16.796840045
2019-02-03 08:14:59 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_ringfill/blt-hang: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:16
2019-02-03 08:14:59 piglit run igt -t igt.gem_userptr_blits.process-exit-gtt /tmp/lkp/piglit-results -x igt.gem_userptr_blits.process-exit-gtt.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_userptr_blits.process-exit-gtt.seconds: 2.701056527
2019-02-03 08:15:02 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_userptr_blits/process-exit-gtt: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:02 piglit run igt -t igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-cur-indfb-move /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-cur-indfb-move.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-cur-indfb-move.seconds: 2.603642695
2019-02-03 08:15:05 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/fbcpsr-2p-primscrn-cur-indfb-move: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:05 piglit run igt -t igt.kms_flip_event_leak /tmp/lkp/piglit-results -x igt.kms_flip_event_leak.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_flip_event_leak.seconds: 3.026371815
2019-02-03 08:15:08 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_flip_event_leak: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:08 piglit run igt -t igt.kms_frontbuffer_tracking.psr-rgb565-draw-mmap-wc /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.psr-rgb565-draw-mmap-wc.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.psr-rgb565-draw-mmap-wc.seconds: 2.840081961
2019-02-03 08:15:11 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/psr-rgb565-draw-mmap-wc: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:11 piglit run igt -t igt.kms_frontbuffer_tracking.fbcpsr-1p-primscrn-pri-shrfb-draw-blt /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.fbcpsr-1p-primscrn-pri-shrfb-draw-blt.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.fbcpsr-1p-primscrn-pri-shrfb-draw-blt.seconds: 2.642466487
2019-02-03 08:15:13 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/fbcpsr-1p-primscrn-pri-shrfb-draw-blt: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:14 piglit run igt -t igt.kms_frontbuffer_tracking.fbcpsr-2p-scndscrn-spr-indfb-move /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.fbcpsr-2p-scndscrn-spr-indfb-move.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.fbcpsr-2p-scndscrn-spr-indfb-move.seconds: 2.850988880
2019-02-03 08:15:16 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/fbcpsr-2p-scndscrn-spr-indfb-move: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:17 piglit run igt -t igt.gem_exec_suspend.bsd-cached /tmp/lkp/piglit-results -x igt.gem_exec_suspend.bsd-cached.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_suspend.bsd-cached.seconds: 2.777249238
2019-02-03 08:15:19 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_suspend/bsd-cached: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:19 piglit run igt -t igt.kms_frontbuffer_tracking.fbc-2p-primscrn-spr-indfb-draw-mmap-gtt /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.fbc-2p-primscrn-spr-indfb-draw-mmap-gtt.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.fbc-2p-primscrn-spr-indfb-draw-mmap-gtt.seconds: 2.716339301
2019-02-03 08:15:22 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/fbc-2p-primscrn-spr-indfb-draw-mmap-gtt: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:22 piglit run igt -t igt.gem_tiling_max_stride /tmp/lkp/piglit-results -x igt.gem_tiling_max_stride.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_tiling_max_stride.seconds: 2.829327101
2019-02-03 08:15:25 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_tiling_max_stride: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:25 piglit run igt -t igt.gem_tiled_partial_pwrite_pread.reads /tmp/lkp/piglit-results -x igt.gem_tiled_partial_pwrite_pread.reads.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_tiled_partial_pwrite_pread.reads.seconds: 2.805113699
2019-02-03 08:15:28 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_tiled_partial_pwrite_pread/reads: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:28 piglit run igt -t igt.pm_rpm.pc8-residency /tmp/lkp/piglit-results -x igt.pm_rpm.pc8-residency.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.pm_rpm.pc8-residency.seconds: 3.837482526
2019-02-03 08:15:32 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/pm_rpm/pc8-residency: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:03
2019-02-03 08:15:32 piglit run igt -t igt.gem_userptr_blits.minor-sync-interruptible /tmp/lkp/piglit-results -x igt.gem_userptr_blits.minor-sync-interruptible.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_userptr_blits.minor-sync-interruptible.seconds: 2.827291321
2019-02-03 08:15:35 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_userptr_blits/minor-sync-interruptible: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:35 piglit run igt -t igt.gem_exec_reloc.readonly-28 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-28.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-28.seconds: 2.909678744
2019-02-03 08:15:38 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-28: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:38 piglit run igt -t igt.gem_exec_reloc.readonly-29 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-29.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-29.seconds: 3.018197459
2019-02-03 08:15:41 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-29: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:41 piglit run igt -t igt.gem_exec_reloc.readonly-26 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-26.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-26.seconds: 2.813224518
2019-02-03 08:15:44 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-26: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:44 piglit run igt -t igt.gem_exec_reloc.readonly-27 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-27.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-27.seconds: 2.905709930
2019-02-03 08:15:47 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-27: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:47 piglit run igt -t igt.gem_exec_reloc.readonly-24 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-24.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-24.seconds: 2.895326735
2019-02-03 08:15:50 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-24: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:50 piglit run igt -t igt.gem_exec_reloc.readonly-25 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-25.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-25.seconds: 2.917729832
2019-02-03 08:15:53 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-25: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:53 piglit run igt -t igt.gem_exec_reloc.readonly-22 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-22.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-22.seconds: 2.942825007
2019-02-03 08:15:56 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-22: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:56 piglit run igt -t igt.gem_exec_reloc.readonly-23 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-23.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-23.seconds: 2.832153494
2019-02-03 08:15:59 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-23: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:59 piglit run igt -t igt.gem_exec_reloc.readonly-20 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-20.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-20.seconds: 2.926182743
2019-02-03 08:16:02 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-20: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:02 piglit run igt -t igt.gem_exec_reloc.readonly-21 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-21.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-21.seconds: 2.925447865
2019-02-03 08:16:05 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-21: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:05 piglit run igt -t igt.kms_frontbuffer_tracking.psr-1p-primscrn-pri-indfb-draw-mmap-cpu /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.psr-1p-primscrn-pri-indfb-draw-mmap-cpu.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.psr-1p-primscrn-pri-indfb-draw-mmap-cpu.seconds: 2.784413209
2019-02-03 08:16:08 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/psr-1p-primscrn-pri-indfb-draw-mmap-cpu: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:08 piglit run igt -t igt.kms_frontbuffer_tracking.psr-1p-primscrn-spr-indfb-draw-pwrite /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.psr-1p-primscrn-spr-indfb-draw-pwrite.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.psr-1p-primscrn-spr-indfb-draw-pwrite.seconds: 2.657844409
2019-02-03 08:16:11 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/psr-1p-primscrn-spr-indfb-draw-pwrite: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:11 piglit run igt -t igt.prime_nv_api.nv_self_import /tmp/lkp/piglit-results -x igt.prime_nv_api.nv_self_import.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.prime_nv_api.nv_self_import.seconds: 2.643016701
2019-02-03 08:16:14 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/prime_nv_api/nv_self_import: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:14 piglit run igt -t igt.kms_frontbuffer_tracking.psr-2p-primscrn-spr-indfb-draw-blt /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.psr-2p-primscrn-spr-indfb-draw-blt.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.psr-2p-primscrn-spr-indfb-draw-blt.seconds: 2.773871730
2019-02-03 08:16:16 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/psr-2p-primscrn-spr-indfb-draw-blt: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:17 piglit run igt -t igt.gem_userptr_blits.forked-unsync-multifd-normal /tmp/lkp/piglit-results -x igt.gem_userptr_blits.forked-unsync-multifd-normal.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_userptr_blits.forked-unsync-multifd-normal.seconds: 3.211131126
2019-02-03 08:16:20 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_userptr_blits/forked-unsync-multifd-normal: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:20 piglit run igt -t igt.gem_ctx_param.invalid-param-get /tmp/lkp/piglit-results -x igt.gem_ctx_param.invalid-param-get.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_ctx_param.invalid-param-get.seconds: 2.720709369
2019-02-03 08:16:23 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_ctx_param/invalid-param-get: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:23 piglit run igt -t igt.gem_userptr_blits.access-control /tmp/lkp/piglit-results -x igt.gem_userptr_blits.access-control.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_userptr_blits.access-control.seconds: 2.771689202
2019-02-03 08:16:25 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_userptr_blits/access-control: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:26 piglit run igt -t igt.gem_exec_nop.blt /tmp/lkp/piglit-results -x igt.gem_exec_nop.blt.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_nop.blt.seconds: 2.734797807
2019-02-03 08:16:28 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_nop/blt: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:28 piglit run igt -t igt.gem_cs_tlb.blt /tmp/lkp/piglit-results -x igt.gem_cs_tlb.blt.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_cs_tlb.blt.seconds: 3.018913697
2019-02-03 08:16:31 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_cs_tlb/blt: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:32 piglit run igt -t igt.gem_ppgtt.blt-vs-render-ctx0 /tmp/lkp/piglit-results -x igt.gem_ppgtt.blt-vs-render-ctx0.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_ppgtt.blt-vs-render-ctx0.seconds: 25.125787680
2019-02-03 08:16:57 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_ppgtt/blt-vs-render-ctx0: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:24
2019-02-03 08:16:57 piglit run igt -t igt.gem_exec_suspend.blt-uncached /tmp/lkp/piglit-results -x igt.gem_exec_suspend.blt-uncached.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_suspend.blt-uncached.seconds: 2.796296991
2019-02-03 08:17:00 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_suspend/blt-uncached: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:17:00 piglit run igt -t igt.prime_nv_api.i915_self_import /tmp/lkp/piglit-results -x igt.prime_nv_api.i915_self_import.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.prime_nv_api.i915_self_import.seconds: 2.593749849
2019-02-03 08:17:02 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/prime_nv_api/i915_self_import: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:17:02 piglit run igt -t igt.kms_cursor_crc.cursor-512x512-random /tmp/lkp/piglit-results -x igt.kms_cursor_crc.cursor-512x512-random.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_cursor_crc.cursor-512x512-random.seconds: 2.652053403
2019-02-03 08:17:05 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_cursor_crc/cursor-512x512-random: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:17:05 piglit run igt -t igt.gem_ring_sync_copy.sync-render-blitter-read-write /tmp/lkp/piglit-results -x igt.gem_ring_sync_copy.sync-render-blitter-read-write.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_ring_sync_copy.sync-render-blitter-read-write.seconds: 3.050107773
2019-02-03 08:17:08 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_ring_sync_copy/sync-render-blitter-read-write: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:17:08 piglit run igt -t igt.gem_reset_stats.reset-count-ctx-bsd /tmp/lkp/piglit-results -x igt.gem_reset_stats.reset-count-ctx-bsd.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_reset_stats.reset-count-ctx-bsd.seconds: 16.664606195
2019-02-03 08:17:25 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_reset_stats/reset-count-ctx-bsd: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:16
2019-02-03 08:17:25 piglit run igt -t igt.kms_frontbuffer_tracking.fbcpsr-modesetfrombusy /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.fbcpsr-modesetfrombusy.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.fbcpsr-modesetfrombusy.seconds: 2.680962383
2019-02-03 08:17:28 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/fbcpsr-modesetfrombusy: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:17:28 piglit run igt -t igt.gem_evict_everything.forked-swapping-normal /tmp/lkp/piglit-results -x igt.gem_evict_everything.forked-swapping-normal.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_evict_everything.forked-swapping-normal.seconds: 3.095002452
2019-02-03 08:17:31 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_evict_everything/forked-swapping-normal: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:17:31 piglit run igt -t igt.gem_ppgtt.blt-vs-render-ctxn /tmp/lkp/piglit-results -x igt.gem_ppgtt.blt-vs-render-ctxn.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_ppgtt.blt-vs-render-ctxn.seconds: 25.343055678
2019-02-03 08:17:56 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_ppgtt/blt-vs-render-ctxn: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:24
2019-02-03 08:17:57 piglit run igt -t igt.gem_reset_stats.ban-blt /tmp/lkp/piglit-results -x igt.gem_reset_stats.ban-blt.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_reset_stats.ban-blt.seconds: 68.495083125
2019-02-03 08:19:05 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_reset_stats/ban-blt: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:01:08
2019-02-03 08:19:05 piglit run igt -t igt.drv_suspend.sysfs-reader-hibernate /tmp/lkp/piglit-results -x igt.drv_suspend.sysfs-reader-hibernate.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.drv_suspend.sysfs-reader-hibernate.seconds: 4.000094269
2019-02-03 08:19:09 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/drv_suspend/sysfs-reader-hibernate: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:03
2019-02-03 08:19:09 piglit run igt -t igt.kms_frontbuffer_tracking.psr-2p-scndscrn-pri-shrfb-draw-pwrite /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.psr-2p-scndscrn-pri-shrfb-draw-pwrite.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.psr-2p-scndscrn-pri-shrfb-draw-pwrite.seconds: 2.657628052
2019-02-03 08:19:12 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/psr-2p-scndscrn-pri-shrfb-draw-pwrite: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:19:12 piglit run igt -t igt.kms_rotation_crc.primary-rotation-180 /tmp/lkp/piglit-results -x igt.kms_rotation_crc.primary-rotation-180.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_rotation_crc.primary-rotation-180.seconds: 20.429793386
2019-02-03 08:19:32 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_rotation_crc/primary-rotation-180: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:19
2019-02-03 08:19:33 piglit run igt -t igt.gem_pwrite_pread.display-copy-correctness /tmp/lkp/piglit-results -x igt.gem_pwrite_pread.display-copy-correctness.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_pwrite_pread.display-copy-correctness.seconds: 2.683935227
2019-02-03 08:19:35 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_pwrite_pread/display-copy-correctness: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:19:35 piglit run igt -t igt.gem_ringfill.bsd2-bomb /tmp/lkp/piglit-results -x igt.gem_ringfill.bsd2-bomb.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_ringfill.bsd2-bomb.seconds: 2.836688473
2019-02-03 08:19:38 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_ringfill/bsd2-bomb: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:19:38 piglit run igt -t igt.kms_frontbuffer_tracking.psr-1p-primscrn-spr-indfb-draw-blt /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.psr-1p-primscrn-spr-indfb-draw-blt.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.psr-1p-primscrn-spr-indfb-draw-blt.seconds: 2.659223847
2019-02-03 08:19:41 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/psr-1p-primscrn-spr-indfb-draw-blt: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
all tests finished



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml



Thanks,
Rong Chen

--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.0.0-rc1-00512-gcf3a71f"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.0.0-rc1 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
# CONFIG_QUEUED_LOCK_STAT is not set
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_EFI_MIXED is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_TEST_SUSPEND=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
# CONFIG_VHOST_VSOCK is not set
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_DEV_PAGEMAP_OPS=y
# CONFIG_HMM_MIRROR is not set
# CONFIG_DEVICE_PRIVATE is not set
# CONFIG_DEVICE_PUBLIC is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
# CONFIG_TCP_CONG_DCTCP is not set
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=m
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
# CONFIG_NFT_MASQ is not set
# CONFIG_NFT_REDIR is not set
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
# CONFIG_NFT_QUEUE is not set
# CONFIG_NFT_QUOTA is not set
# CONFIG_NFT_REJECT is not set
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
# CONFIG_IP_SET_HASH_IPMARK is not set
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
# CONFIG_IP_SET_HASH_IPMAC is not set
# CONFIG_IP_SET_HASH_MAC is not set
# CONFIG_IP_SET_HASH_NETPORTNET is not set
CONFIG_IP_SET_HASH_NET=m
# CONFIG_IP_SET_HASH_NETNET is not set
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
# CONFIG_NF_SOCKET_IPV4 is not set
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_IPV4=m
CONFIG_NF_NAT_MASQUERADE_IPV4=y
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_NF_NAT_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
# CONFIG_IP6_NF_NAT is not set
CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
# CONFIG_NET_ACT_SAMPLE is not set
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_VLAN is not set
# CONFIG_NET_ACT_BPF is not set
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
# CONFIG_VIRTIO_VSOCKETS is not set
# CONFIG_HYPERV_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_FAILOVER=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCI_HYPERV is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_VMD is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#
# CONFIG_MTD_REDBOOT_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
# CONFIG_XEN_BLKDEV_BACKEND is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_RSXX=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_FC is not set
# CONFIG_NVME_TARGET_TCP is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
# CONFIG_TCM_QLA2XXX is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
CONFIG_SCSI_OSD_INITIATOR=m
CONFIG_SCSI_OSD_ULD=m
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_ERA is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
# CONFIG_ISCSI_TARGET_CXGB4 is not set
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=m
CONFIG_NET_VRF=y
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
CONFIG_IXGB=m
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=m
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
CONFIG_SKGE_DEBUG=y
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
CONFIG_SKY2_DEBUG=y
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=m
CONFIG_NETXEN_NIC=m
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
# CONFIG_SFC_FALCON is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_ASIX_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
# CONFIG_XEN_NETDEV_BACKEND is not set
CONFIG_VMXNET3=m
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=y
CONFIG_ISDN=y
CONFIG_ISDN_I4L=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_IPPP_FILTER=y
# CONFIG_ISDN_PPP_BSDCOMP is not set
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DIVERSION=m

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
# CONFIG_ISDN_DRV_HISAX is not set
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPIDRV=m
# CONFIG_ISDN_CAPI_CAPIDRV_VERBOSE is not set

#
# CAPI hardware drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_ISDN_HDLC=m
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_OLPC_APSP is not set
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=m
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=m
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_AT91_USART is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
# CONFIG_LIRC is not set
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_XMP_DECODER=m
# CONFIG_IR_IMON_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_M52790=m

#
# Sensors used on soc_camera driver
#

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_GP8PSK_FE=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
CONFIG_LOGO=y
# CONFIG_FB_LOGO_CENTER is not set
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
# CONFIG_SND_HDA_RECONFIG is not set
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
# CONFIG_HDMI_LPE_AUDIO is not set
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
CONFIG_I2C_HID=m

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_MON=y
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
CONFIG_USB_DWC3_HAPS=y
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_DUMMY_HCD is not set
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_MASS_STORAGE=m
# CONFIG_USB_CONFIGFS is not set
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
CONFIG_USB_MASS_STORAGE=m
# CONFIG_USB_GADGET_TARGET is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_G_WEBCAM is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
# CONFIG_EDAC_GHES is not set
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
# CONFIG_EDAC_IE31200 is not set
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_PND2 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV8803 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_HV_GENERIC is not set
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI_IGD=y
# CONFIG_VFIO_MDEV is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_SELFBALLOONING is not set
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=m
CONFIG_XEN_PCIDEV_BACKEND=m
# CONFIG_XEN_PVCALLS_FRONTEND is not set
# CONFIG_XEN_PVCALLS_BACKEND is not set
# CONFIG_XEN_SCSI_BACKEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_ACPI_PROCESSOR=m
# CONFIG_XEN_MCE_LOG is not set
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_SYMS=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_R8822BE is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_PI433 is not set
# CONFIG_MTK_MMC is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_EROFS_FS is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
# CONFIG_DELL_SMBIOS is not set
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_IOVA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# NXP/Freescale QorIQ SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FS_ENCRYPTION=y
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EXOFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
# CONFIG_NFSD_SCSILAYOUT is not set
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SUNRPC_DEBUG=y
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_ACL=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE=1
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="selinux"
CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
# CONFIG_CRYPTO_DEV_CHELSIO is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=m
# CONFIG_STRING_SELFTEST is not set

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_TRACING_EVENTS_GPIO=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=m
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=m
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_ASYNC_RAID6_TEST=m
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=m
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_EFI is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set

--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='piglit'
	export testcase='piglit'
	export category='functional'
	export timeout='15m'
	export job_origin='/lkp/lkp/.src-20190201-101644/allot/cyclic:default:linux-devel:devel-hourly/lkp-skl-d01/piglit-igt.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='validate'
	export testbox='lkp-skl-d01'
	export tbox_group='lkp-skl-d01'
	export submit_id='5c562a430b9a935a7d0850eb'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d01/piglit-igt-008-debian-x86_64-2018-04-03.cgz-cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3-20190203-88701-1qgvwhj-3.yaml'
	export id='441bb5a2103c28dc02e937e819237e4f2213ebcb'
	export queuer_version='/lkp/lkp/.src-20190201-101644'
	export need_kconfig='CONFIG_DRM_VGEM=m'
	export commit='cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3'
	export kconfig='x86_64-rhel-7.2'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2018-04-03.cgz'
	export enqueue_time='2019-02-03 07:39:47 +0800'
	export _id='5c562a430b9a935a7d0850ed'
	export _rt='/result/piglit/igt-008/lkp-skl-d01/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3'
	export user='lkp'
	export head_commit='732a695474137c522a8a6a306f78332506c28863'
	export base_commit='f17b5f06cb92ef2250513a1e154c47b78df07d40'
	export branch='linux-devel/devel-hourly-2019020107'
	export result_root='/result/piglit/igt-008/lkp-skl-d01/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3/3'
	export scheduler_version='/lkp/lkp/.src-20190201-101644'
	export LKP_SERVER='inn'
	export max_uptime=900
	export initrd='/osimage/debian/debian-x86_64-2018-04-03.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d01/piglit-igt-008-debian-x86_64-2018-04-03.cgz-cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3-20190203-88701-1qgvwhj-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.2
branch=linux-devel/devel-hourly-2019020107
commit=cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.2/gcc-7/cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3/vmlinuz-5.0.0-rc1-00512-gcf3a71f
max_uptime=900
RESULT_ROOT=/result/piglit/igt-008/lkp-skl-d01/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3/3
LKP_SERVER=inn
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.2/gcc-7/cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/piglit_2018-09-14.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/piglit-x86_64-c0350279c_2018-09-13.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2016-11-15.cgz'
	export lkp_initrd='/lkp/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=4
	export schedule_notify_address=
	export model='Skylake'
	export nr_cpu=8
	export memory='8G'
	export nr_hdd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD10EZEX-75WN4A0_WD-WCC6Y2JD9SLU-part1'
	export swap_partitions='/dev/disk/by-id/ata-WDC_WD10EZEX-75WN4A0_WD-WCC6Y2JD9SLU-part3'
	export rootfs_partition='/dev/disk/by-id/ata-WDC_WD10EZEX-75WN4A0_WD-WCC6Y2JD9SLU-part2'
	export brand='Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz'
	export cpu_info='skylake i7-6700'
	export bios_version='1.2.8'
	export kernel='/pkg/linux/x86_64-rhel-7.2/gcc-7/cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3/vmlinuz-5.0.0-rc1-00512-gcf3a71f'
	export dequeue_time='2019-02-03 08:10:34 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d01/piglit-igt-008-debian-x86_64-2018-04-03.cgz-cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3-20190203-88701-1qgvwhj-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='igt-008' $LKP_SRC/tests/wrapper piglit
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper piglit
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time piglit.time
	$LKP_SRC/stats/wrapper time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper last_state
}

"$@"

--2B/JsCI69OhZNC5r
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AgAAAAAEWVo=

--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=piglit

igt/gem_pread/basic: ignored_by_lkp
igt/gem_exec_suspend/basic-s3: ignored_by_lkp
igt/gem_exec_suspend/basic-s4: ignored_by_lkp
igt/kms_pipe_crc_basic/read-crc-pipe-b-frame-sequence: ignored_by_lkp
igt/gem_exec_create/basic: ignored_by_lkp
igt/gem_ringfill/basic-default-hang: ignored_by_lkp
igt/kms_flip/basic-flip-vs-wf_vblank: ignored_by_lkp
igt/kms_addfb_basic/addfb25-bad-modifier: ignored_by_lkp
2019-02-03 08:11:25 piglit run igt -t igt.gem_pread.snoop /tmp/lkp/piglit-results -x igt.gem_pread.snoop.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_pread.snoop.seconds: 2.975972718
2019-02-03 08:11:28 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_pread/snoop: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:28 piglit run igt -t igt.gem_ppgtt.flink-and-close-vma-leak /tmp/lkp/piglit-results -x igt.gem_ppgtt.flink-and-close-vma-leak.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_ppgtt.flink-and-close-vma-leak.seconds: 2.799894404
2019-02-03 08:11:31 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_ppgtt/flink-and-close-vma-leak: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:31 piglit run igt -t igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-pri-shrfb-draw-render /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-pri-shrfb-draw-render.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-pri-shrfb-draw-render.seconds: 2.599347761
2019-02-03 08:11:33 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/fbcpsr-2p-primscrn-pri-shrfb-draw-render: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:33 piglit run igt -t igt.prime_mmap.test_refcounting /tmp/lkp/piglit-results -x igt.prime_mmap.test_refcounting.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.prime_mmap.test_refcounting.seconds: 2.756003767
2019-02-03 08:11:36 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/prime_mmap/test_refcounting: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:36 piglit run igt -t igt.gem_userptr_blits.process-exit-gtt-busy /tmp/lkp/piglit-results -x igt.gem_userptr_blits.process-exit-gtt-busy.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_userptr_blits.process-exit-gtt-busy.seconds: 2.655476570
2019-02-03 08:11:39 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_userptr_blits/process-exit-gtt-busy: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:39 piglit run igt -t igt.gem_shrink.execbufn /tmp/lkp/piglit-results -x igt.gem_shrink.execbufn.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_shrink.execbufn.seconds: 3.139317779
2019-02-03 08:11:42 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_shrink/execbufn: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:42 piglit run igt -t igt.kms_flip.2x-flip-vs-panning-vs-hang /tmp/lkp/piglit-results -x igt.kms_flip.2x-flip-vs-panning-vs-hang.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_flip.2x-flip-vs-panning-vs-hang.seconds: 2.807247350
2019-02-03 08:11:45 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_flip/2x-flip-vs-panning-vs-hang: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:45 piglit run igt -t igt.kms_frontbuffer_tracking.psr-rgb101010-draw-blt /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.psr-rgb101010-draw-blt.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.psr-rgb101010-draw-blt.seconds: 2.686419254
2019-02-03 08:11:48 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/psr-rgb101010-draw-blt: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:48 piglit run igt -t igt.gem_exec_whisper.interruptible /tmp/lkp/piglit-results -x igt.gem_exec_whisper.interruptible.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_whisper.interruptible.seconds: 2.770487557
2019-02-03 08:11:51 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_whisper/interruptible: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:51 piglit run igt -t igt.gem_exec_basic.gtt-default /tmp/lkp/piglit-results -x igt.gem_exec_basic.gtt-default.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_basic.gtt-default.seconds: 2.992537692
2019-02-03 08:11:54 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_basic/gtt-default: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:11:54 piglit run igt -t igt.kms_flip.flip-vs-panning-vs-hang-interruptible /tmp/lkp/piglit-results -x igt.kms_flip.flip-vs-panning-vs-hang-interruptible.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_flip.flip-vs-panning-vs-hang-interruptible.seconds: 99.946972485
2019-02-03 08:13:34 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_flip/flip-vs-panning-vs-hang-interruptible: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:01:39
2019-02-03 08:13:34 piglit run igt -t igt.gem_evict_alignment.major-interruptible /tmp/lkp/piglit-results -x igt.gem_evict_alignment.major-interruptible.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_evict_alignment.major-interruptible.seconds: 2.890800136
2019-02-03 08:13:37 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_evict_alignment/major-interruptible: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:13:37 piglit run igt -t igt.gem_shrink.execbufn-userptr /tmp/lkp/piglit-results -x igt.gem_shrink.execbufn-userptr.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_shrink.execbufn-userptr.seconds: 2.916673143
2019-02-03 08:13:40 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_shrink/execbufn-userptr: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:13:40 piglit run igt -t igt.gem_wait.invalid-buf /tmp/lkp/piglit-results -x igt.gem_wait.invalid-buf.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_wait.invalid-buf.seconds: 2.758484468
2019-02-03 08:13:43 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_wait/invalid-buf: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:13:43 piglit run igt -t igt.gem_shrink.execbuf1 /tmp/lkp/piglit-results -x igt.gem_shrink.execbuf1.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_shrink.execbuf1.seconds: 3.009269350
2019-02-03 08:13:46 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_shrink/execbuf1: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:13:46 piglit run igt -t igt.pm_rc6_residency.media-rc6-accuracy /tmp/lkp/piglit-results -x igt.pm_rc6_residency.media-rc6-accuracy.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.pm_rc6_residency.media-rc6-accuracy.seconds: 2.827380181
2019-02-03 08:13:49 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/pm_rc6_residency/media-rc6-accuracy: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:13:49 piglit run igt -t igt.gem_reset_stats.close-pending-fork-blt /tmp/lkp/piglit-results -x igt.gem_reset_stats.close-pending-fork-blt.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_reset_stats.close-pending-fork-blt.seconds: 18.983046998
2019-02-03 08:14:08 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_reset_stats/close-pending-fork-blt: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:18
2019-02-03 08:14:08 piglit run igt -t igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-cur-indfb-draw-render /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-cur-indfb-draw-render.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-cur-indfb-draw-render.seconds: 2.778737407
2019-02-03 08:14:11 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/fbcpsr-2p-primscrn-cur-indfb-draw-render: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:14:11 piglit run igt -t igt.gem_exec_parallel.default /tmp/lkp/piglit-results -x igt.gem_exec_parallel.default.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_parallel.default.seconds: 2.797506102
2019-02-03 08:14:14 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_parallel/default: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:14:14 piglit run igt -t igt.gem_ring_sync_loop /tmp/lkp/piglit-results -x igt.gem_ring_sync_loop.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_ring_sync_loop.seconds: 2.706546964
2019-02-03 08:14:17 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_ring_sync_loop: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:14:17 piglit run igt -t igt.kms_chv_cursor_fail.pipe-c-64x64-bottom-edge /tmp/lkp/piglit-results -x igt.kms_chv_cursor_fail.pipe-c-64x64-bottom-edge.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_chv_cursor_fail.pipe-c-64x64-bottom-edge.seconds: 5.720606088
2019-02-03 08:14:22 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_chv_cursor_fail/pipe-c-64x64-bottom-edge: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:05
2019-02-03 08:14:23 piglit run igt -t igt.prime_nv_api.nv_self_import_to_different_fd /tmp/lkp/piglit-results -x igt.prime_nv_api.nv_self_import_to_different_fd.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.prime_nv_api.nv_self_import_to_different_fd.seconds: 2.679634197
2019-02-03 08:14:25 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/prime_nv_api/nv_self_import_to_different_fd: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:14:25 piglit run igt -t igt.gem_userptr_blits.input-checking /tmp/lkp/piglit-results -x igt.gem_userptr_blits.input-checking.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_userptr_blits.input-checking.seconds: 2.720751300
2019-02-03 08:14:28 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_userptr_blits/input-checking: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:14:28 piglit run igt -t igt.kms_frontbuffer_tracking.psr-1p-offscren-pri-shrfb-draw-render /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.psr-1p-offscren-pri-shrfb-draw-render.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.psr-1p-offscren-pri-shrfb-draw-render.seconds: 2.523358599
2019-02-03 08:14:31 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/psr-1p-offscren-pri-shrfb-draw-render: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:14:31 piglit run igt -t igt.gem_reset_stats.close-pending-fork-reverse-bsd1 /tmp/lkp/piglit-results -x igt.gem_reset_stats.close-pending-fork-reverse-bsd1.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_reset_stats.close-pending-fork-reverse-bsd1.seconds: 2.738541521
2019-02-03 08:14:34 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_reset_stats/close-pending-fork-reverse-bsd1: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:14:34 piglit run igt -t igt.gem_reset_stats.close-pending-fork-reverse-bsd2 /tmp/lkp/piglit-results -x igt.gem_reset_stats.close-pending-fork-reverse-bsd2.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_reset_stats.close-pending-fork-reverse-bsd2.seconds: 2.714301437
2019-02-03 08:14:36 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_reset_stats/close-pending-fork-reverse-bsd2: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:14:36 piglit run igt -t igt.kms_chv_cursor_fail.pipe-b-64x64-right-edge /tmp/lkp/piglit-results -x igt.kms_chv_cursor_fail.pipe-b-64x64-right-edge.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_chv_cursor_fail.pipe-b-64x64-right-edge.seconds: 5.712827792
2019-02-03 08:14:42 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_chv_cursor_fail/pipe-b-64x64-right-edge: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:05
2019-02-03 08:14:42 piglit run igt -t igt.gem_ringfill.blt-hang /tmp/lkp/piglit-results -x igt.gem_ringfill.blt-hang.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_ringfill.blt-hang.seconds: 16.796840045
2019-02-03 08:14:59 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_ringfill/blt-hang: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:16
2019-02-03 08:14:59 piglit run igt -t igt.gem_userptr_blits.process-exit-gtt /tmp/lkp/piglit-results -x igt.gem_userptr_blits.process-exit-gtt.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_userptr_blits.process-exit-gtt.seconds: 2.701056527
2019-02-03 08:15:02 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_userptr_blits/process-exit-gtt: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:02 piglit run igt -t igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-cur-indfb-move /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-cur-indfb-move.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-cur-indfb-move.seconds: 2.603642695
2019-02-03 08:15:05 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/fbcpsr-2p-primscrn-cur-indfb-move: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:05 piglit run igt -t igt.kms_flip_event_leak /tmp/lkp/piglit-results -x igt.kms_flip_event_leak.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_flip_event_leak.seconds: 3.026371815
2019-02-03 08:15:08 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_flip_event_leak: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:08 piglit run igt -t igt.kms_frontbuffer_tracking.psr-rgb565-draw-mmap-wc /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.psr-rgb565-draw-mmap-wc.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.psr-rgb565-draw-mmap-wc.seconds: 2.840081961
2019-02-03 08:15:11 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/psr-rgb565-draw-mmap-wc: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:11 piglit run igt -t igt.kms_frontbuffer_tracking.fbcpsr-1p-primscrn-pri-shrfb-draw-blt /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.fbcpsr-1p-primscrn-pri-shrfb-draw-blt.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.fbcpsr-1p-primscrn-pri-shrfb-draw-blt.seconds: 2.642466487
2019-02-03 08:15:13 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/fbcpsr-1p-primscrn-pri-shrfb-draw-blt: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:14 piglit run igt -t igt.kms_frontbuffer_tracking.fbcpsr-2p-scndscrn-spr-indfb-move /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.fbcpsr-2p-scndscrn-spr-indfb-move.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.fbcpsr-2p-scndscrn-spr-indfb-move.seconds: 2.850988880
2019-02-03 08:15:16 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/fbcpsr-2p-scndscrn-spr-indfb-move: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:17 piglit run igt -t igt.gem_exec_suspend.bsd-cached /tmp/lkp/piglit-results -x igt.gem_exec_suspend.bsd-cached.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_suspend.bsd-cached.seconds: 2.777249238
2019-02-03 08:15:19 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_suspend/bsd-cached: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:19 piglit run igt -t igt.kms_frontbuffer_tracking.fbc-2p-primscrn-spr-indfb-draw-mmap-gtt /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.fbc-2p-primscrn-spr-indfb-draw-mmap-gtt.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.fbc-2p-primscrn-spr-indfb-draw-mmap-gtt.seconds: 2.716339301
2019-02-03 08:15:22 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/fbc-2p-primscrn-spr-indfb-draw-mmap-gtt: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:22 piglit run igt -t igt.gem_tiling_max_stride /tmp/lkp/piglit-results -x igt.gem_tiling_max_stride.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_tiling_max_stride.seconds: 2.829327101
2019-02-03 08:15:25 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_tiling_max_stride: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:25 piglit run igt -t igt.gem_tiled_partial_pwrite_pread.reads /tmp/lkp/piglit-results -x igt.gem_tiled_partial_pwrite_pread.reads.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_tiled_partial_pwrite_pread.reads.seconds: 2.805113699
2019-02-03 08:15:28 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_tiled_partial_pwrite_pread/reads: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:28 piglit run igt -t igt.pm_rpm.pc8-residency /tmp/lkp/piglit-results -x igt.pm_rpm.pc8-residency.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.pm_rpm.pc8-residency.seconds: 3.837482526
2019-02-03 08:15:32 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/pm_rpm/pc8-residency: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:03
2019-02-03 08:15:32 piglit run igt -t igt.gem_userptr_blits.minor-sync-interruptible /tmp/lkp/piglit-results -x igt.gem_userptr_blits.minor-sync-interruptible.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_userptr_blits.minor-sync-interruptible.seconds: 2.827291321
2019-02-03 08:15:35 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_userptr_blits/minor-sync-interruptible: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:35 piglit run igt -t igt.gem_exec_reloc.readonly-28 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-28.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-28.seconds: 2.909678744
2019-02-03 08:15:38 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-28: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:38 piglit run igt -t igt.gem_exec_reloc.readonly-29 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-29.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-29.seconds: 3.018197459
2019-02-03 08:15:41 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-29: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:41 piglit run igt -t igt.gem_exec_reloc.readonly-26 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-26.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-26.seconds: 2.813224518
2019-02-03 08:15:44 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-26: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:44 piglit run igt -t igt.gem_exec_reloc.readonly-27 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-27.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-27.seconds: 2.905709930
2019-02-03 08:15:47 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-27: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:47 piglit run igt -t igt.gem_exec_reloc.readonly-24 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-24.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-24.seconds: 2.895326735
2019-02-03 08:15:50 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-24: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:50 piglit run igt -t igt.gem_exec_reloc.readonly-25 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-25.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-25.seconds: 2.917729832
2019-02-03 08:15:53 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-25: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:53 piglit run igt -t igt.gem_exec_reloc.readonly-22 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-22.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-22.seconds: 2.942825007
2019-02-03 08:15:56 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-22: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:56 piglit run igt -t igt.gem_exec_reloc.readonly-23 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-23.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-23.seconds: 2.832153494
2019-02-03 08:15:59 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-23: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:15:59 piglit run igt -t igt.gem_exec_reloc.readonly-20 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-20.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-20.seconds: 2.926182743
2019-02-03 08:16:02 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-20: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:02 piglit run igt -t igt.gem_exec_reloc.readonly-21 /tmp/lkp/piglit-results -x igt.gem_exec_reloc.readonly-21.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_reloc.readonly-21.seconds: 2.925447865
2019-02-03 08:16:05 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_reloc/readonly-21: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:05 piglit run igt -t igt.kms_frontbuffer_tracking.psr-1p-primscrn-pri-indfb-draw-mmap-cpu /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.psr-1p-primscrn-pri-indfb-draw-mmap-cpu.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.psr-1p-primscrn-pri-indfb-draw-mmap-cpu.seconds: 2.784413209
2019-02-03 08:16:08 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/psr-1p-primscrn-pri-indfb-draw-mmap-cpu: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:08 piglit run igt -t igt.kms_frontbuffer_tracking.psr-1p-primscrn-spr-indfb-draw-pwrite /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.psr-1p-primscrn-spr-indfb-draw-pwrite.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.psr-1p-primscrn-spr-indfb-draw-pwrite.seconds: 2.657844409
2019-02-03 08:16:11 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/psr-1p-primscrn-spr-indfb-draw-pwrite: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:11 piglit run igt -t igt.prime_nv_api.nv_self_import /tmp/lkp/piglit-results -x igt.prime_nv_api.nv_self_import.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.prime_nv_api.nv_self_import.seconds: 2.643016701
2019-02-03 08:16:14 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/prime_nv_api/nv_self_import: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:14 piglit run igt -t igt.kms_frontbuffer_tracking.psr-2p-primscrn-spr-indfb-draw-blt /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.psr-2p-primscrn-spr-indfb-draw-blt.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.psr-2p-primscrn-spr-indfb-draw-blt.seconds: 2.773871730
2019-02-03 08:16:16 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/psr-2p-primscrn-spr-indfb-draw-blt: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:17 piglit run igt -t igt.gem_userptr_blits.forked-unsync-multifd-normal /tmp/lkp/piglit-results -x igt.gem_userptr_blits.forked-unsync-multifd-normal.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_userptr_blits.forked-unsync-multifd-normal.seconds: 3.211131126
2019-02-03 08:16:20 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_userptr_blits/forked-unsync-multifd-normal: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:20 piglit run igt -t igt.gem_ctx_param.invalid-param-get /tmp/lkp/piglit-results -x igt.gem_ctx_param.invalid-param-get.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_ctx_param.invalid-param-get.seconds: 2.720709369
2019-02-03 08:16:23 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_ctx_param/invalid-param-get: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:23 piglit run igt -t igt.gem_userptr_blits.access-control /tmp/lkp/piglit-results -x igt.gem_userptr_blits.access-control.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_userptr_blits.access-control.seconds: 2.771689202
2019-02-03 08:16:25 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_userptr_blits/access-control: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:26 piglit run igt -t igt.gem_exec_nop.blt /tmp/lkp/piglit-results -x igt.gem_exec_nop.blt.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_nop.blt.seconds: 2.734797807
2019-02-03 08:16:28 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_nop/blt: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:28 piglit run igt -t igt.gem_cs_tlb.blt /tmp/lkp/piglit-results -x igt.gem_cs_tlb.blt.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_cs_tlb.blt.seconds: 3.018913697
2019-02-03 08:16:31 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_cs_tlb/blt: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:16:32 piglit run igt -t igt.gem_ppgtt.blt-vs-render-ctx0 /tmp/lkp/piglit-results -x igt.gem_ppgtt.blt-vs-render-ctx0.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_ppgtt.blt-vs-render-ctx0.seconds: 25.125787680
2019-02-03 08:16:57 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_ppgtt/blt-vs-render-ctx0: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:24
2019-02-03 08:16:57 piglit run igt -t igt.gem_exec_suspend.blt-uncached /tmp/lkp/piglit-results -x igt.gem_exec_suspend.blt-uncached.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_exec_suspend.blt-uncached.seconds: 2.796296991
2019-02-03 08:17:00 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_exec_suspend/blt-uncached: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:17:00 piglit run igt -t igt.prime_nv_api.i915_self_import /tmp/lkp/piglit-results -x igt.prime_nv_api.i915_self_import.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.prime_nv_api.i915_self_import.seconds: 2.593749849
2019-02-03 08:17:02 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/prime_nv_api/i915_self_import: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:17:02 piglit run igt -t igt.kms_cursor_crc.cursor-512x512-random /tmp/lkp/piglit-results -x igt.kms_cursor_crc.cursor-512x512-random.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_cursor_crc.cursor-512x512-random.seconds: 2.652053403
2019-02-03 08:17:05 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_cursor_crc/cursor-512x512-random: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:17:05 piglit run igt -t igt.gem_ring_sync_copy.sync-render-blitter-read-write /tmp/lkp/piglit-results -x igt.gem_ring_sync_copy.sync-render-blitter-read-write.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_ring_sync_copy.sync-render-blitter-read-write.seconds: 3.050107773
2019-02-03 08:17:08 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_ring_sync_copy/sync-render-blitter-read-write: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:17:08 piglit run igt -t igt.gem_reset_stats.reset-count-ctx-bsd /tmp/lkp/piglit-results -x igt.gem_reset_stats.reset-count-ctx-bsd.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_reset_stats.reset-count-ctx-bsd.seconds: 16.664606195
2019-02-03 08:17:25 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_reset_stats/reset-count-ctx-bsd: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:16
2019-02-03 08:17:25 piglit run igt -t igt.kms_frontbuffer_tracking.fbcpsr-modesetfrombusy /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.fbcpsr-modesetfrombusy.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.fbcpsr-modesetfrombusy.seconds: 2.680962383
2019-02-03 08:17:28 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/fbcpsr-modesetfrombusy: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:17:28 piglit run igt -t igt.gem_evict_everything.forked-swapping-normal /tmp/lkp/piglit-results -x igt.gem_evict_everything.forked-swapping-normal.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_evict_everything.forked-swapping-normal.seconds: 3.095002452
2019-02-03 08:17:31 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_evict_everything/forked-swapping-normal: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:17:31 piglit run igt -t igt.gem_ppgtt.blt-vs-render-ctxn /tmp/lkp/piglit-results -x igt.gem_ppgtt.blt-vs-render-ctxn.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_ppgtt.blt-vs-render-ctxn.seconds: 25.343055678
2019-02-03 08:17:56 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_ppgtt/blt-vs-render-ctxn: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:24
2019-02-03 08:17:57 piglit run igt -t igt.gem_reset_stats.ban-blt /tmp/lkp/piglit-results -x igt.gem_reset_stats.ban-blt.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_reset_stats.ban-blt.seconds: 68.495083125
2019-02-03 08:19:05 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_reset_stats/ban-blt: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:01:08
2019-02-03 08:19:05 piglit run igt -t igt.drv_suspend.sysfs-reader-hibernate /tmp/lkp/piglit-results -x igt.drv_suspend.sysfs-reader-hibernate.
[1/1] fail: 1 |
[1/1] fail: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.drv_suspend.sysfs-reader-hibernate.seconds: 4.000094269
2019-02-03 08:19:09 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/drv_suspend/sysfs-reader-hibernate: fail
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              1
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:03
2019-02-03 08:19:09 piglit run igt -t igt.kms_frontbuffer_tracking.psr-2p-scndscrn-pri-shrfb-draw-pwrite /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.psr-2p-scndscrn-pri-shrfb-draw-pwrite.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.psr-2p-scndscrn-pri-shrfb-draw-pwrite.seconds: 2.657628052
2019-02-03 08:19:12 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/psr-2p-scndscrn-pri-shrfb-draw-pwrite: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:19:12 piglit run igt -t igt.kms_rotation_crc.primary-rotation-180 /tmp/lkp/piglit-results -x igt.kms_rotation_crc.primary-rotation-180.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_rotation_crc.primary-rotation-180.seconds: 20.429793386
2019-02-03 08:19:32 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_rotation_crc/primary-rotation-180: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:19
2019-02-03 08:19:33 piglit run igt -t igt.gem_pwrite_pread.display-copy-correctness /tmp/lkp/piglit-results -x igt.gem_pwrite_pread.display-copy-correctness.
[1/1] pass: 1 |
[1/1] pass: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_pwrite_pread.display-copy-correctness.seconds: 2.683935227
2019-02-03 08:19:35 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_pwrite_pread/display-copy-correctness: pass
summary:
       name: piglit-results
       ----  --------------
       pass:              1
       fail:              0
      crash:              0
       skip:              0
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:19:35 piglit run igt -t igt.gem_ringfill.bsd2-bomb /tmp/lkp/piglit-results -x igt.gem_ringfill.bsd2-bomb.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.gem_ringfill.bsd2-bomb.seconds: 2.836688473
2019-02-03 08:19:38 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/gem_ringfill/bsd2-bomb: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
2019-02-03 08:19:38 piglit run igt -t igt.kms_frontbuffer_tracking.psr-1p-primscrn-spr-indfb-draw-blt /tmp/lkp/piglit-results -x igt.kms_frontbuffer_tracking.psr-1p-primscrn-spr-indfb-draw-blt.
[1/1] skip: 1 |
[1/1] skip: 1  

             
Thank you for running Piglit!
Results have been written to /tmp/lkp/piglit-results
igt.kms_frontbuffer_tracking.psr-1p-primscrn-spr-indfb-draw-blt.seconds: 2.659223847
2019-02-03 08:19:41 piglit summary console /tmp/lkp/piglit-results/results.json.bz2
igt/kms_frontbuffer_tracking/psr-1p-primscrn-spr-indfb-draw-blt: skip
summary:
       name: piglit-results
       ----  --------------
       pass:              0
       fail:              0
      crash:              0
       skip:              1
    timeout:              0
       warn:              0
 incomplete:              0
 dmesg-warn:              0
 dmesg-fail:              0
    changes:              0
      fixes:              0
regressions:              0
      total:              1
       time:       00:00:02
all tests finished

--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/piglit-igt.yaml
suite: piglit
testcase: piglit
category: functional
timeout: 15m
piglit:
  group: igt-008
job_origin: "/lkp/lkp/.src-20190201-101644/allot/cyclic:default:linux-devel:devel-hourly/lkp-skl-d01/piglit-igt.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d01
tbox_group: lkp-skl-d01
submit_id: 5c561e870b9a9340a5d992e6
job_file: "/lkp/jobs/scheduled/lkp-skl-d01/piglit-igt-008-debian-x86_64-2018-04-03.cgz-cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3-20190203-82085-1x9f6q5-0.yaml"
id: e98bb9e9824b4c0a22145efd20f84a422067cef2
queuer_version: "/lkp/lkp/.src-20190201-101644"

#! hosts/lkp-skl-d01

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/piglit
need_kconfig:
- CONFIG_DRM_VGEM=m

#! include/queue/cyclic
commit: cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3

#! default params
kconfig: x86_64-rhel-7.2
compiler: gcc-7
rootfs: debian-x86_64-2018-04-03.cgz
enqueue_time: 2019-02-03 06:49:44.450613339 +08:00
_id: 5c561e870b9a9340a5d992e6
_rt: "/result/piglit/igt-008/lkp-skl-d01/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3"

#! schedule options
user: lkp
head_commit: 732a695474137c522a8a6a306f78332506c28863
base_commit: f17b5f06cb92ef2250513a1e154c47b78df07d40
branch: linux-devel/devel-hourly-2019020107
result_root: "/result/piglit/igt-008/lkp-skl-d01/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3/0"
scheduler_version: "/lkp/lkp/.src-20190201-101644"
LKP_SERVER: inn
max_uptime: 900
initrd: "/osimage/debian/debian-x86_64-2018-04-03.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d01/piglit-igt-008-debian-x86_64-2018-04-03.cgz-cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3-20190203-82085-1x9f6q5-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.2
- branch=linux-devel/devel-hourly-2019020107
- commit=cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.2/gcc-7/cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3/vmlinuz-5.0.0-rc1-00512-gcf3a71f
- max_uptime=900
- RESULT_ROOT=/result/piglit/igt-008/lkp-skl-d01/debian-x86_64-2018-04-03.cgz/x86_64-rhel-7.2/gcc-7/cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3/0
- LKP_SERVER=inn
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-7.2/gcc-7/cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/piglit_2018-09-14.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/piglit-x86_64-c0350279c_2018-09-13.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2016-11-15.cgz"
lkp_initrd: "/lkp/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20190201-101644/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
schedule_notify_address: 
model: Skylake
nr_cpu: 8
memory: 8G
nr_hdd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD10EZEX-75WN4A0_WD-WCC6Y2JD9SLU-part1"
swap_partitions: "/dev/disk/by-id/ata-WDC_WD10EZEX-75WN4A0_WD-WCC6Y2JD9SLU-part3"
rootfs_partition: "/dev/disk/by-id/ata-WDC_WD10EZEX-75WN4A0_WD-WCC6Y2JD9SLU-part2"
brand: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz
cpu_info: skylake i7-6700
bios_version: 1.2.8

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-7.2/gcc-7/cf3a71f2fb4bcc6812c1c3f8800a8be9563072d3/vmlinuz-5.0.0-rc1-00512-gcf3a71f"
dequeue_time: 2019-02-03 07:29:25.961957282 +08:00
job_state: finished
loadavg: 0.83 0.87 0.47 1/177 28566
start_time: '1549150221'
end_time: '1549150722'
version: "/lkp/lkp/.src-20190201-101644"

--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "piglit" "run" "igt" "-t" "igt.gem_pread.snoop" "/tmp/lkp/piglit-results" "-x" "igt.gem_pread.snoop."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_ppgtt.flink-and-close-vma-leak" "/tmp/lkp/piglit-results" "-x" "igt.gem_ppgtt.flink-and-close-vma-leak."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-pri-shrfb-draw-render" "/tmp/lkp/piglit-results" "-x" "igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-pri-shrfb-draw-render."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.prime_mmap.test_refcounting" "/tmp/lkp/piglit-results" "-x" "igt.prime_mmap.test_refcounting."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_userptr_blits.process-exit-gtt-busy" "/tmp/lkp/piglit-results" "-x" "igt.gem_userptr_blits.process-exit-gtt-busy."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_shrink.execbufn" "/tmp/lkp/piglit-results" "-x" "igt.gem_shrink.execbufn."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_flip.2x-flip-vs-panning-vs-hang" "/tmp/lkp/piglit-results" "-x" "igt.kms_flip.2x-flip-vs-panning-vs-hang."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_frontbuffer_tracking.psr-rgb101010-draw-blt" "/tmp/lkp/piglit-results" "-x" "igt.kms_frontbuffer_tracking.psr-rgb101010-draw-blt."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_exec_whisper.interruptible" "/tmp/lkp/piglit-results" "-x" "igt.gem_exec_whisper.interruptible."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_exec_basic.gtt-default" "/tmp/lkp/piglit-results" "-x" "igt.gem_exec_basic.gtt-default."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_flip.flip-vs-panning-vs-hang-interruptible" "/tmp/lkp/piglit-results" "-x" "igt.kms_flip.flip-vs-panning-vs-hang-interruptible."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_evict_alignment.major-interruptible" "/tmp/lkp/piglit-results" "-x" "igt.gem_evict_alignment.major-interruptible."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_shrink.execbufn-userptr" "/tmp/lkp/piglit-results" "-x" "igt.gem_shrink.execbufn-userptr."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_wait.invalid-buf" "/tmp/lkp/piglit-results" "-x" "igt.gem_wait.invalid-buf."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_shrink.execbuf1" "/tmp/lkp/piglit-results" "-x" "igt.gem_shrink.execbuf1."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.pm_rc6_residency.media-rc6-accuracy" "/tmp/lkp/piglit-results" "-x" "igt.pm_rc6_residency.media-rc6-accuracy."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_reset_stats.close-pending-fork-blt" "/tmp/lkp/piglit-results" "-x" "igt.gem_reset_stats.close-pending-fork-blt."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-cur-indfb-draw-render" "/tmp/lkp/piglit-results" "-x" "igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-cur-indfb-draw-render."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_exec_parallel.default" "/tmp/lkp/piglit-results" "-x" "igt.gem_exec_parallel.default."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_ring_sync_loop" "/tmp/lkp/piglit-results" "-x" "igt.gem_ring_sync_loop."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_chv_cursor_fail.pipe-c-64x64-bottom-edge" "/tmp/lkp/piglit-results" "-x" "igt.kms_chv_cursor_fail.pipe-c-64x64-bottom-edge."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.prime_nv_api.nv_self_import_to_different_fd" "/tmp/lkp/piglit-results" "-x" "igt.prime_nv_api.nv_self_import_to_different_fd."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_userptr_blits.input-checking" "/tmp/lkp/piglit-results" "-x" "igt.gem_userptr_blits.input-checking."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_frontbuffer_tracking.psr-1p-offscren-pri-shrfb-draw-render" "/tmp/lkp/piglit-results" "-x" "igt.kms_frontbuffer_tracking.psr-1p-offscren-pri-shrfb-draw-render."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_reset_stats.close-pending-fork-reverse-bsd1" "/tmp/lkp/piglit-results" "-x" "igt.gem_reset_stats.close-pending-fork-reverse-bsd1."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_reset_stats.close-pending-fork-reverse-bsd2" "/tmp/lkp/piglit-results" "-x" "igt.gem_reset_stats.close-pending-fork-reverse-bsd2."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_chv_cursor_fail.pipe-b-64x64-right-edge" "/tmp/lkp/piglit-results" "-x" "igt.kms_chv_cursor_fail.pipe-b-64x64-right-edge."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_ringfill.blt-hang" "/tmp/lkp/piglit-results" "-x" "igt.gem_ringfill.blt-hang."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_userptr_blits.process-exit-gtt" "/tmp/lkp/piglit-results" "-x" "igt.gem_userptr_blits.process-exit-gtt."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-cur-indfb-move" "/tmp/lkp/piglit-results" "-x" "igt.kms_frontbuffer_tracking.fbcpsr-2p-primscrn-cur-indfb-move."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_flip_event_leak" "/tmp/lkp/piglit-results" "-x" "igt.kms_flip_event_leak."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_frontbuffer_tracking.psr-rgb565-draw-mmap-wc" "/tmp/lkp/piglit-results" "-x" "igt.kms_frontbuffer_tracking.psr-rgb565-draw-mmap-wc."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_frontbuffer_tracking.fbcpsr-1p-primscrn-pri-shrfb-draw-blt" "/tmp/lkp/piglit-results" "-x" "igt.kms_frontbuffer_tracking.fbcpsr-1p-primscrn-pri-shrfb-draw-blt."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_frontbuffer_tracking.fbcpsr-2p-scndscrn-spr-indfb-move" "/tmp/lkp/piglit-results" "-x" "igt.kms_frontbuffer_tracking.fbcpsr-2p-scndscrn-spr-indfb-move."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_exec_suspend.bsd-cached" "/tmp/lkp/piglit-results" "-x" "igt.gem_exec_suspend.bsd-cached."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_frontbuffer_tracking.fbc-2p-primscrn-spr-indfb-draw-mmap-gtt" "/tmp/lkp/piglit-results" "-x" "igt.kms_frontbuffer_tracking.fbc-2p-primscrn-spr-indfb-draw-mmap-gtt."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_tiling_max_stride" "/tmp/lkp/piglit-results" "-x" "igt.gem_tiling_max_stride."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_tiled_partial_pwrite_pread.reads" "/tmp/lkp/piglit-results" "-x" "igt.gem_tiled_partial_pwrite_pread.reads."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.pm_rpm.pc8-residency" "/tmp/lkp/piglit-results" "-x" "igt.pm_rpm.pc8-residency."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_userptr_blits.minor-sync-interruptible" "/tmp/lkp/piglit-results" "-x" "igt.gem_userptr_blits.minor-sync-interruptible."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_exec_reloc.readonly-28" "/tmp/lkp/piglit-results" "-x" "igt.gem_exec_reloc.readonly-28."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_exec_reloc.readonly-29" "/tmp/lkp/piglit-results" "-x" "igt.gem_exec_reloc.readonly-29."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_exec_reloc.readonly-26" "/tmp/lkp/piglit-results" "-x" "igt.gem_exec_reloc.readonly-26."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_exec_reloc.readonly-27" "/tmp/lkp/piglit-results" "-x" "igt.gem_exec_reloc.readonly-27."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_exec_reloc.readonly-24" "/tmp/lkp/piglit-results" "-x" "igt.gem_exec_reloc.readonly-24."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_exec_reloc.readonly-25" "/tmp/lkp/piglit-results" "-x" "igt.gem_exec_reloc.readonly-25."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_exec_reloc.readonly-22" "/tmp/lkp/piglit-results" "-x" "igt.gem_exec_reloc.readonly-22."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_exec_reloc.readonly-23" "/tmp/lkp/piglit-results" "-x" "igt.gem_exec_reloc.readonly-23."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_exec_reloc.readonly-20" "/tmp/lkp/piglit-results" "-x" "igt.gem_exec_reloc.readonly-20."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_exec_reloc.readonly-21" "/tmp/lkp/piglit-results" "-x" "igt.gem_exec_reloc.readonly-21."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_frontbuffer_tracking.psr-1p-primscrn-pri-indfb-draw-mmap-cpu" "/tmp/lkp/piglit-results" "-x" "igt.kms_frontbuffer_tracking.psr-1p-primscrn-pri-indfb-draw-mmap-cpu."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_frontbuffer_tracking.psr-1p-primscrn-spr-indfb-draw-pwrite" "/tmp/lkp/piglit-results" "-x" "igt.kms_frontbuffer_tracking.psr-1p-primscrn-spr-indfb-draw-pwrite."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.prime_nv_api.nv_self_import" "/tmp/lkp/piglit-results" "-x" "igt.prime_nv_api.nv_self_import."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_frontbuffer_tracking.psr-2p-primscrn-spr-indfb-draw-blt" "/tmp/lkp/piglit-results" "-x" "igt.kms_frontbuffer_tracking.psr-2p-primscrn-spr-indfb-draw-blt."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_userptr_blits.forked-unsync-multifd-normal" "/tmp/lkp/piglit-results" "-x" "igt.gem_userptr_blits.forked-unsync-multifd-normal."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_ctx_param.invalid-param-get" "/tmp/lkp/piglit-results" "-x" "igt.gem_ctx_param.invalid-param-get."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_userptr_blits.access-control" "/tmp/lkp/piglit-results" "-x" "igt.gem_userptr_blits.access-control."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_exec_nop.blt" "/tmp/lkp/piglit-results" "-x" "igt.gem_exec_nop.blt."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_cs_tlb.blt" "/tmp/lkp/piglit-results" "-x" "igt.gem_cs_tlb.blt."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_ppgtt.blt-vs-render-ctx0" "/tmp/lkp/piglit-results" "-x" "igt.gem_ppgtt.blt-vs-render-ctx0."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_exec_suspend.blt-uncached" "/tmp/lkp/piglit-results" "-x" "igt.gem_exec_suspend.blt-uncached."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.prime_nv_api.i915_self_import" "/tmp/lkp/piglit-results" "-x" "igt.prime_nv_api.i915_self_import."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_cursor_crc.cursor-512x512-random" "/tmp/lkp/piglit-results" "-x" "igt.kms_cursor_crc.cursor-512x512-random."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_ring_sync_copy.sync-render-blitter-read-write" "/tmp/lkp/piglit-results" "-x" "igt.gem_ring_sync_copy.sync-render-blitter-read-write."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_reset_stats.reset-count-ctx-bsd" "/tmp/lkp/piglit-results" "-x" "igt.gem_reset_stats.reset-count-ctx-bsd."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_frontbuffer_tracking.fbcpsr-modesetfrombusy" "/tmp/lkp/piglit-results" "-x" "igt.kms_frontbuffer_tracking.fbcpsr-modesetfrombusy."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_evict_everything.forked-swapping-normal" "/tmp/lkp/piglit-results" "-x" "igt.gem_evict_everything.forked-swapping-normal."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_ppgtt.blt-vs-render-ctxn" "/tmp/lkp/piglit-results" "-x" "igt.gem_ppgtt.blt-vs-render-ctxn."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_reset_stats.ban-blt" "/tmp/lkp/piglit-results" "-x" "igt.gem_reset_stats.ban-blt."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.drv_suspend.sysfs-reader-hibernate" "/tmp/lkp/piglit-results" "-x" "igt.drv_suspend.sysfs-reader-hibernate."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_frontbuffer_tracking.psr-2p-scndscrn-pri-shrfb-draw-pwrite" "/tmp/lkp/piglit-results" "-x" "igt.kms_frontbuffer_tracking.psr-2p-scndscrn-pri-shrfb-draw-pwrite."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_rotation_crc.primary-rotation-180" "/tmp/lkp/piglit-results" "-x" "igt.kms_rotation_crc.primary-rotation-180."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_pwrite_pread.display-copy-correctness" "/tmp/lkp/piglit-results" "-x" "igt.gem_pwrite_pread.display-copy-correctness."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.gem_ringfill.bsd2-bomb" "/tmp/lkp/piglit-results" "-x" "igt.gem_ringfill.bsd2-bomb."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"
 "piglit" "run" "igt" "-t" "igt.kms_frontbuffer_tracking.psr-1p-primscrn-spr-indfb-draw-blt" "/tmp/lkp/piglit-results" "-x" "igt.kms_frontbuffer_tracking.psr-1p-primscrn-spr-indfb-draw-blt."
 "piglit" "summary" "console" "/tmp/lkp/piglit-results/results.json.bz2"

--2B/JsCI69OhZNC5r--

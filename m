Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbeFDKzD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:55:03 -0400
Received: from david.siemens.de ([192.35.17.14]:41234 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751418AbeFDKzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:55:01 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Jailhouse 0.9 released
To: Jailhouse <jailhouse-dev@googlegroups.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mozilla-News-Host: news://news://blaine.gmane.org
Openpgp: preference=signencrypt
Autocrypt: addr=jan.kiszka@siemens.com; prefer-encrypt=mutual; keydata=
 xsDhBEq0i8QRBAD2wOxlC9m/8t/vqjm1U9yQCT6OJ2Wbv/qys9DYM0CvcOTDMWQwmV1/VsZj
 KR5YgB5NPt+To7X6x5cjz15AGnx5Fb8Wnrq8EF9ZfHMwb7YMx1LdPYPDnXr37wE3XupFmkHB
 Mes4htyX7Dz8LvKDLnli4IsAmWG+kV1JI6LWKXLpSwCg8JRq4SWoB4VCQxbH3GjntgvwNc8D
 /2q5Dj0urJ7s7sdXhrH0hcFkpSFRmU5Yd6MCwcbFHm2paL5gqVjNNUUwDBKAL9eZaQVIHKwC
 44BvNGO2gcQ26R3AuCHUQ+pZHg34tok1JCNZ6IEZccb+33Qq0qbcDMJJiDYp7ppp6ozifvc4
 YaqJECX48IydxfE9+41oV7T5vNAzA/QL/UMJyTnu5jiOXcyn5iFQw535lXkwKsqeXzCowLho
 HICZ2jITJPdTT/+9pGWwMQqST/SS35Tx4EnS3z2BWsNMCLuXCPkxF1elaMJqMfMJxFD8rAgS
 9GK6zP6fJlsA1wq/UvKSL8v4QPOnTNCVOsyqJVasGV0ZPcDfcj+ClNO4zR5KYW4gS2lzemth
 IDxqYW4ua2lzemthQHdlYi5kZT7CYwQTEQIAIwIbIwYLCQgHAwIEFQIIAwQWAgMBAh4BAheA
 BQJOpoNtAhkBAAoJEIrUrG965ecUOPUAoK+Rh12KgCjplHAS0AoiGKwGOuq7AKDEVnBtRAoy
 VRvp3lOlOx+P2Ay56M7BTQRKtIvEEAgA2/PlX6oyi7dToH0CJCHq0eKmZaa7CmGaVnxyeepK
 vIfiM8n8Td76AbG64fjREMwgSpb4F/UytF3z/03tj4e49W/zKjbBRB2/wmFRlZBC9crg22Q+
 bgvMOsxnC6uHXaWN8fL+jVei/5OoHOoFqaMsX8EvploitlI/BPj+VgW26jksf3YZyk1hncls
 Z/IYhXzgRmVJo4RiTW/YLQAkwndwc+fKPa/IYLEDW1Jc4kNLoK0P90b45zju0hpl0C00pVOR
 TOtzFK9G5Ha7qOAWJfAVJORHKAkkvwftf3hkpPdLyvZUWRHXvUexmA61fLvDBAFhRxYGD8t5
 gz88SF5Tzq+0ywADBQf/YSkaYrEslPWiCA2wU6EW0yaqBQAobFsOMvsufJ6o2ntq5Ncq37VI
 3KCT67eHPE9x+zPcENoZWsRrC9S9PCf1LOsi7ybZsR13AJqDFlRzJZ4klh9QwgwFZxUBzOdI
 vttwzG1QkzHx06RKZluFYpPF3DRduSMukdIJ2wmWCU+ohB+mYefe65JGjYQfHVs8mgYVFOPx
 bRea9VJACCMuspoZWpj43UdR1lLLyIUFYz+jqcPW7Hd/GTIw4N67pYl0dwPDmFd4ohJ5g4Zp
 q61toNysBGEuEm5GCcn0VmGtQpSYnR5cVm5b2yPz4bIuFOSuZUo/l7vitdY0iy0/wvKbBC+N
 K8JJBBgRAgAJBQJKtIvEAhsMAAoJEIrUrG965ecULvAAoKGvxs5T3IhyQT8I8sMsyAvCE4wH
 AJ46S16yab+OxNkvOeoOEX0EnHVHaA==
Message-ID: <7cbb746a-4141-6b17-269a-ec3e791c4e3f@siemens.com>
Date: Mon, 4 Jun 2018 12:54:58 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are happy to have completed a new version of the partitioning
hypervisor Jailhouse. The release got delayed a couple of times,
primarily due to the introduction of MMU support to ARM demo inmates.
But now it's done and working.

Code changes are fewer than for the previous release, but the number of
commits is almost this same: 171 commits, 240 files changed, 4458
insertions, 1925 deletions.

- New targets:
   - emtrion emCON-RZ/G1H
   - NXP MCIMX8M-EVK
   - NVIDIA Jetson TX2
- Cross-arch changes:
   - introduce unit infrastructure to hypervisor, simplifying build-time
     additions of complex features
   - unify command line section of demo inmates to be at 0x1000 (check
     your scripts!)
   - improve Linux loader command with better control over kernel vs.
     initramfs distance (can resolve non-root Linux startup issues)
   - versioning for communication region with evaluation in inmates
   - work around potentially missing EXPORT_SYMBOLs for driver via
     kallsyms lookup
   - per-architecture configs/ folders (make sure your custom configs
     are moved as well!)
   - first steps to create comprehensive man pages
   - Xilinx ZynqMP Ultrascale+ bring-up README
- ARM / ARM64:
   - run demo inmates with MMU and caches enabled (ensures ivshmem &
     comm region coherency, improves average latencies)
   - GICv3: emulate GICR_TYPER_Last correctly
   - GICv2: correctly emulate SGI sender ID
   - add compressed image support for ARM64 Linux loader
   - fixes and improvements of vPCI DT overlay setup
   - stable vPCI controller domain via linux,pci-domain node
- x86:
   - various MMIO instruction emulator fixes and enhancements
   - unit test for MMIO instruction emulator
   - intercept all AMD SVM instructions for safety/security reasons
   - fix hypercall instruction selection in demo inmates

You can download the new release from

    https://github.com/siemens/jailhouse/archive/v0.9.tar.gz

then follow the README.md for first steps on recommended evaluation
platforms and check the tutorial session from ELC-E 2016 [1][2]. To try
out Jailhouse in a virtual environment, there is no an image generator
available [3]. It will soon be updated to the new release as well. Drop
us a note on the mailing list if you run into trouble.

Meanwhile, more guest-side patches for Jailhouse are making it into
upstream. The x86-specific side is now done, and now there are several
patches for ARM lined up, namely hot-plugging the generic PCI host
controller. After that only a few smaller bits and - see also below -
the inter-cell communication interface are missing.

There are now a couple of important post-release changes in the make,
some fairly advanced, others still requiring more work:

 - Per-CPU hypervisor page tables, both making the core agnostic against
   known Spectre attacks and simplifying the per-cpu data accesses.
   Patches are ready, just waiting for this release - and some update of
   the internal documentation.

 - Rework of demo inmates, adding SMP support on ARM/ARM64, likely also
   restructuring the library further.

 - Proper, reusable Python binding for the management interface. Will
   help with internal Python code reuse and open up new external use
   cases.

 - Finalizing the inter-cell communication interface, exploiting virtio
   more extensively without compromising hypervisor simplicity. There
   has been some significant progress on the concept recently, the
   keyword is "Virtio shared-memory transport". But more on this soon.

Thanks to all the contributors and supporters! We are happy to see the
ecosystem growing steadily.

Jan

[1] https://events.linuxfoundation.org/sites/events/files/slides/ELCE2016-Jailhouse-Tutorial.pdf
[2] https://youtu.be/7fiJbwmhnRw?list=PLbzoR-pLrL6pRFP6SOywVJWdEHlmQE51q
[3] https://github.com/siemens/jailhouse-images

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

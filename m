Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753305AbeDMBmr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 21:42:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:45930 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752628AbeDMBmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 21:42:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,444,1517904000";
   d="gz'50?scan'50,208,50";a="220033890"
Date: Fri, 13 Apr 2018 09:42:22 +0800
From: kbuild test robot <lkp@intel.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: kbuild-all@01.org, Jessica Yu <jeyu@kernel.org>,
        Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module: silence a gcc warning
Message-ID: <201804130919.rVD09XI8%fengguang.wu@intel.com>
References: <20180411190509.24995-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20180411190509.24995-1-malat@debian.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mathieu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16 next-20180412]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mathieu-Malaterre/kernel-module-silence-a-gcc-warning/20180413-044304
config: x86_64-randconfig-u0-04130525 (attached as .config)
compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/cavium/common/cavium_ptp.c:7:0:
>> include/linux/module.h:794:13: warning: 'struct tracepoint' declared inside parameter list
         struct tracepoint * const *tp);
                ^
>> include/linux/module.h:794:13: warning: its scope is only this definition or declaration, which is probably not what you want
   Cyclomatic Complexity 1 include/linux/err.h:ERR_PTR
   Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
   Cyclomatic Complexity 1 include/linux/err.h:IS_ERR
   Cyclomatic Complexity 3 include/linux/err.h:IS_ERR_OR_NULL
   Cyclomatic Complexity 1 include/linux/math64.h:div_u64_rem
   Cyclomatic Complexity 1 include/linux/math64.h:div_u64
   Cyclomatic Complexity 1 include/linux/spinlock.h:spinlock_check
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock_irqrestore
   Cyclomatic Complexity 1 include/linux/time64.h:timespec64_to_ns
   Cyclomatic Complexity 1 include/linux/timekeeping.h:ktime_get_real
   Cyclomatic Complexity 1 arch/x86/include/asm/io.h:readq
   Cyclomatic Complexity 1 arch/x86/include/asm/io.h:writeq
   Cyclomatic Complexity 1 include/linux/kobject.h:kobject_name
   Cyclomatic Complexity 1 include/linux/device.h:devm_kzalloc
   Cyclomatic Complexity 2 include/linux/device.h:dev_name
   Cyclomatic Complexity 1 include/linux/device.h:dev_get_drvdata
   Cyclomatic Complexity 1 include/linux/device.h:dev_set_drvdata
   Cyclomatic Complexity 1 include/linux/timecounter.h:timecounter_adjtime
   Cyclomatic Complexity 1 include/linux/pci.h:pci_get_drvdata
   Cyclomatic Complexity 1 include/linux/pci.h:pci_set_drvdata
   Cyclomatic Complexity 1 include/linux/pci.h:pci_name
   Cyclomatic Complexity 1 include/linux/ptp_clock_kernel.h:ptp_clock_register
   Cyclomatic Complexity 1 include/linux/ptp_clock_kernel.h:ptp_clock_unregister
   Cyclomatic Complexity 1 drivers/net/ethernet/cavium/common/cavium_ptp.c:cavium_ptp_enable
   Cyclomatic Complexity 2 drivers/net/ethernet/cavium/common/cavium_ptp.c:cavium_ptp_remove
   Cyclomatic Complexity 4 drivers/net/ethernet/cavium/common/cavium_ptp.c:cavium_ptp_get
   Cyclomatic Complexity 2 drivers/net/ethernet/cavium/common/cavium_ptp.c:cavium_ptp_put
   Cyclomatic Complexity 1 drivers/net/ethernet/cavium/common/cavium_ptp.c:cavium_ptp_driver_init
   Cyclomatic Complexity 2 drivers/net/ethernet/cavium/common/cavium_ptp.c:cavium_ptp_settime
   Cyclomatic Complexity 2 drivers/net/ethernet/cavium/common/cavium_ptp.c:cavium_ptp_gettime
   Cyclomatic Complexity 2 drivers/net/ethernet/cavium/common/cavium_ptp.c:cavium_ptp_adjtime
   Cyclomatic Complexity 4 drivers/net/ethernet/cavium/common/cavium_ptp.c:cavium_ptp_adjfine
   Cyclomatic Complexity 2 drivers/net/ethernet/cavium/common/cavium_ptp.c:cavium_ptp_cc_read
   Cyclomatic Complexity 3 drivers/net/ethernet/cavium/common/cavium_ptp.c:ptp_cavium_clock_get
   Cyclomatic Complexity 6 drivers/net/ethernet/cavium/common/cavium_ptp.c:cavium_ptp_probe
   Cyclomatic Complexity 1 drivers/net/ethernet/cavium/common/cavium_ptp.c:cavium_ptp_driver_exit
--
   In file included from drivers/ntb/ntb.c:58:0:
>> include/linux/module.h:794:13: warning: 'struct tracepoint' declared inside parameter list
         struct tracepoint * const *tp);
                ^
>> include/linux/module.h:794:13: warning: its scope is only this definition or declaration, which is probably not what you want
   Cyclomatic Complexity 1 include/linux/spinlock.h:spinlock_check
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock_irqrestore
   Cyclomatic Complexity 1 include/linux/completion.h:__init_completion
   Cyclomatic Complexity 1 include/linux/kobject.h:kobject_name
   Cyclomatic Complexity 2 include/linux/device.h:dev_name
   Cyclomatic Complexity 3 include/linux/ntb.h:ntb_client_ops_is_valid
   Cyclomatic Complexity 1 include/linux/ntb.h:ntb_ctx_ops_is_valid
   Cyclomatic Complexity 29 include/linux/ntb.h:ntb_dev_ops_is_valid
   Cyclomatic Complexity 1 include/linux/pci.h:pci_name
   Cyclomatic Complexity 3 drivers/ntb/ntb.c:ntb_set_ctx
   Cyclomatic Complexity 1 drivers/ntb/ntb.c:ntb_clear_ctx
   Cyclomatic Complexity 3 drivers/ntb/ntb.c:ntb_link_event
   Cyclomatic Complexity 3 drivers/ntb/ntb.c:ntb_db_event
   Cyclomatic Complexity 3 drivers/ntb/ntb.c:ntb_msg_event
   Cyclomatic Complexity 3 drivers/ntb/ntb.c:ntb_default_port_number
   Cyclomatic Complexity 1 drivers/ntb/ntb.c:ntb_default_peer_port_count
   Cyclomatic Complexity 4 drivers/ntb/ntb.c:ntb_default_peer_port_number
   Cyclomatic Complexity 2 drivers/ntb/ntb.c:ntb_default_peer_port_idx
   Cyclomatic Complexity 3 drivers/ntb/ntb.c:__ntb_register_client
   Cyclomatic Complexity 4 drivers/ntb/ntb.c:ntb_remove
   Cyclomatic Complexity 4 drivers/ntb/ntb.c:ntb_probe
   Cyclomatic Complexity 1 drivers/ntb/ntb.c:ntb_unregister_client
   Cyclomatic Complexity 5 drivers/ntb/ntb.c:ntb_register_device
   Cyclomatic Complexity 2 drivers/ntb/ntb.c:ntb_dev_release
   Cyclomatic Complexity 1 drivers/ntb/ntb.c:ntb_unregister_device
   Cyclomatic Complexity 1 drivers/ntb/ntb.c:ntb_driver_init
   Cyclomatic Complexity 1 drivers/ntb/ntb.c:ntb_driver_exit
--
   In file included from drivers/ntb/hw/amd/ntb_hw_amd.c:55:0:
>> include/linux/module.h:794:13: warning: 'struct tracepoint' declared inside parameter list
         struct tracepoint * const *tp);
                ^
>> include/linux/module.h:794:13: warning: its scope is only this definition or declaration, which is probably not what you want
   Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls64
   Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u64
   Cyclomatic Complexity 1 include/linux/list.h:INIT_LIST_HEAD
   Cyclomatic Complexity 1 arch/x86/include/asm/mem_encrypt.h:sme_active
   Cyclomatic Complexity 1 include/linux/mem_encrypt.h:sme_get_me_mask
   Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
   Cyclomatic Complexity 1 include/linux/spinlock.h:spinlock_check
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock_irqrestore
   Cyclomatic Complexity 1 include/linux/jiffies.h:_msecs_to_jiffies
   Cyclomatic Complexity 3 include/linux/jiffies.h:msecs_to_jiffies
   Cyclomatic Complexity 1 include/linux/workqueue.h:__init_work
   Cyclomatic Complexity 1 include/linux/workqueue.h:queue_delayed_work
   Cyclomatic Complexity 1 include/linux/workqueue.h:schedule_delayed_work
   Cyclomatic Complexity 1 arch/x86/include/asm/io.h:readw
   Cyclomatic Complexity 1 arch/x86/include/asm/io.h:readl
   Cyclomatic Complexity 1 arch/x86/include/asm/io.h:writew
   Cyclomatic Complexity 1 arch/x86/include/asm/io.h:writel
   Cyclomatic Complexity 1 arch/x86/include/asm/io.h:readq
   Cyclomatic Complexity 1 arch/x86/include/asm/io.h:writeq
   Cyclomatic Complexity 1 include/linux/kasan.h:kasan_kmalloc
   Cyclomatic Complexity 28 include/linux/slab.h:kmalloc_index
   Cyclomatic Complexity 1 include/linux/slab.h:__kmalloc_node
   Cyclomatic Complexity 1 include/linux/slab.h:kmem_cache_alloc_node
   Cyclomatic Complexity 1 include/linux/slab.h:kmem_cache_alloc_trace
   Cyclomatic Complexity 1 include/linux/slab.h:kmem_cache_alloc_node_trace
   Cyclomatic Complexity 1 include/linux/slab.h:kmalloc_order_trace
   Cyclomatic Complexity 68 include/linux/slab.h:kmalloc_large
   Cyclomatic Complexity 5 include/linux/slab.h:kmalloc
   Cyclomatic Complexity 5 include/linux/slab.h:kmalloc_node
   Cyclomatic Complexity 1 include/linux/slab.h:kzalloc_node
   Cyclomatic Complexity 1 include/linux/kobject.h:kobject_name
   Cyclomatic Complexity 1 include/linux/interrupt.h:request_irq
   Cyclomatic Complexity 2 include/linux/device.h:dev_name
   Cyclomatic Complexity 1 include/linux/device.h:dev_to_node
   Cyclomatic Complexity 1 include/linux/device.h:dev_get_drvdata
   Cyclomatic Complexity 1 include/linux/device.h:dev_set_drvdata
   Cyclomatic Complexity 1 include/linux/pci.h:pci_dev_msi_enabled
   Cyclomatic Complexity 1 include/linux/pci.h:pci_get_drvdata
   Cyclomatic Complexity 1 include/linux/pci.h:pci_set_drvdata
   Cyclomatic Complexity 1 include/linux/pci.h:pci_name
   Cyclomatic Complexity 1 arch/x86/include/asm/dma-mapping.h:get_arch_dma_ops
   Cyclomatic Complexity 4 include/linux/dma-mapping.h:get_dma_ops
   Cyclomatic Complexity 3 include/linux/dma-mapping.h:dma_check_mask
   Cyclomatic Complexity 4 include/linux/dma-mapping.h:dma_supported
   Cyclomatic Complexity 3 include/linux/dma-mapping.h:dma_set_mask
   Cyclomatic Complexity 4 include/linux/dma-mapping.h:dma_get_mask
   Cyclomatic Complexity 2 include/linux/dma-mapping.h:dma_set_coherent_mask
   Cyclomatic Complexity 2 include/linux/dma-mapping.h:dma_set_mask_and_coherent
   Cyclomatic Complexity 1 include/linux/dma-mapping.h:dma_coerce_mask_and_coherent
   Cyclomatic Complexity 1 include/linux/pci-dma-compat.h:pci_set_dma_mask
   Cyclomatic Complexity 1 include/linux/pci-dma-compat.h:pci_set_consistent_dma_mask
   Cyclomatic Complexity 8 include/linux/ntb.h:ntb_topo_string
   Cyclomatic Complexity 3 drivers/ntb/hw/amd/ntb_hw_amd.c:ndev_mw_to_bar
   Cyclomatic Complexity 5 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_link_is_up
   Cyclomatic Complexity 1 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ack_smu
   Cyclomatic Complexity 1 drivers/ntb/hw/amd/ntb_hw_amd.c:ndev_init_struct
   Cyclomatic Complexity 2 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_init_side_info
   Cyclomatic Complexity 2 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_deinit_side_info
   Cyclomatic Complexity 2 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_get_topo
   Cyclomatic Complexity 2 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_pci_driver_init
   Cyclomatic Complexity 1 drivers/ntb/hw/amd/ntb_hw_amd.c:ndev_deinit_debugfs
   Cyclomatic Complexity 4 drivers/ntb/hw/amd/ntb_hw_amd.c:ndev_deinit_isr
   Cyclomatic Complexity 1 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_deinit_dev
   Cyclomatic Complexity 1 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_deinit_pci
   Cyclomatic Complexity 1 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_pci_remove
   Cyclomatic Complexity 9 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_mw_get_align
   Cyclomatic Complexity 4 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_link_disable
   Cyclomatic Complexity 3 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_mw_count
   Cyclomatic Complexity 4 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_spad_write
   Cyclomatic Complexity 2 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_db_valid_mask
   Cyclomatic Complexity 2 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_db_read
   Cyclomatic Complexity 2 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_peer_db_set
   Cyclomatic Complexity 3 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_db_clear_mask
   Cyclomatic Complexity 7 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_peer_mw_get_addr
   Cyclomatic Complexity 5 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_db_vector_mask
   Cyclomatic Complexity 4 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_peer_spad_read
   Cyclomatic Complexity 2 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_peer_mw_count
   Cyclomatic Complexity 9 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_link_is_up
   Cyclomatic Complexity 2 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_db_vector_count
   Cyclomatic Complexity 4 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_spad_read
   Cyclomatic Complexity 3 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_db_set_mask
   Cyclomatic Complexity 4 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_peer_spad_write
   Cyclomatic Complexity 12 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_mw_set_trans
   Cyclomatic Complexity 4 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_link_enable
   Cyclomatic Complexity 2 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_db_clear
   Cyclomatic Complexity 2 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_spad_count
   Cyclomatic Complexity 9 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_init_pci
   Cyclomatic Complexity 3 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_init_ntb
   Cyclomatic Complexity 8 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_handle_event
   Cyclomatic Complexity 15 drivers/ntb/hw/amd/ntb_hw_amd.c:ndev_init_isr
   Cyclomatic Complexity 1 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_init_isr
   Cyclomatic Complexity 4 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_init_dev
   Cyclomatic Complexity 5 drivers/ntb/hw/amd/ntb_hw_amd.c:ndev_interrupt
   Cyclomatic Complexity 1 drivers/ntb/hw/amd/ntb_hw_amd.c:ndev_irq_isr
   Cyclomatic Complexity 1 drivers/ntb/hw/amd/ntb_hw_amd.c:ndev_vec_isr
   Cyclomatic Complexity 4 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_poll_link
   Cyclomatic Complexity 4 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_link_hb
   Cyclomatic Complexity 3 drivers/ntb/hw/amd/ntb_hw_amd.c:ndev_init_debugfs
   Cyclomatic Complexity 5 drivers/ntb/hw/amd/ntb_hw_amd.c:amd_ntb_pci_probe
--
   In file included from drivers/ntb/hw/idt/ntb_hw_idt.c:47:0:
>> include/linux/module.h:794:13: warning: 'struct tracepoint' declared inside parameter list
         struct tracepoint * const *tp);
                ^
>> include/linux/module.h:794:13: warning: its scope is only this definition or declaration, which is probably not what you want
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls64
   Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u64
   Cyclomatic Complexity 1 arch/x86/include/asm/mem_encrypt.h:sme_active
   Cyclomatic Complexity 1 include/linux/mem_encrypt.h:sme_get_me_mask
   Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
   Cyclomatic Complexity 1 include/linux/err.h:ERR_PTR
   Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
   Cyclomatic Complexity 1 include/linux/err.h:IS_ERR
   Cyclomatic Complexity 3 include/linux/err.h:IS_ERR_OR_NULL
   Cyclomatic Complexity 1 include/linux/spinlock.h:spinlock_check
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock_irqrestore
   Cyclomatic Complexity 1 include/linux/kobject.h:kobject_name
   Cyclomatic Complexity 1 include/linux/kasan.h:kasan_kmalloc
   Cyclomatic Complexity 28 include/linux/slab.h:kmalloc_index
   Cyclomatic Complexity 1 include/linux/slab.h:kmem_cache_alloc_trace
   Cyclomatic Complexity 1 include/linux/slab.h:kmalloc_order_trace
   Cyclomatic Complexity 68 include/linux/slab.h:kmalloc_large
   Cyclomatic Complexity 5 include/linux/slab.h:kmalloc
   Cyclomatic Complexity 1 include/linux/device.h:devm_kzalloc
   Cyclomatic Complexity 3 include/linux/device.h:devm_kmalloc_array
   Cyclomatic Complexity 1 include/linux/device.h:devm_kcalloc
   Cyclomatic Complexity 2 include/linux/device.h:dev_name
   Cyclomatic Complexity 1 include/linux/device.h:dev_get_drvdata
   Cyclomatic Complexity 1 include/linux/device.h:dev_set_drvdata
   Cyclomatic Complexity 1 include/linux/pci.h:pci_alloc_irq_vectors
   Cyclomatic Complexity 1 include/linux/pci.h:pci_get_drvdata
   Cyclomatic Complexity 1 include/linux/pci.h:pci_set_drvdata
   Cyclomatic Complexity 1 include/linux/pci.h:pci_name
   Cyclomatic Complexity 1 arch/x86/include/asm/dma-mapping.h:get_arch_dma_ops
   Cyclomatic Complexity 4 include/linux/dma-mapping.h:get_dma_ops
   Cyclomatic Complexity 3 include/linux/dma-mapping.h:dma_check_mask
   Cyclomatic Complexity 4 include/linux/dma-mapping.h:dma_supported
   Cyclomatic Complexity 3 include/linux/dma-mapping.h:dma_set_mask
   Cyclomatic Complexity 4 include/linux/dma-mapping.h:dma_get_mask
   Cyclomatic Complexity 2 include/linux/dma-mapping.h:dma_set_coherent_mask
   Cyclomatic Complexity 2 include/linux/dma-mapping.h:dma_set_mask_and_coherent
   Cyclomatic Complexity 1 include/linux/dma-mapping.h:dma_coerce_mask_and_coherent
   Cyclomatic Complexity 1 include/linux/pci-dma-compat.h:pci_set_dma_mask
   Cyclomatic Complexity 1 include/linux/pci-dma-compat.h:pci_set_consistent_dma_mask
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_reg_set_bits
   Cyclomatic Complexity 1 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_reg_clear_bits
   Cyclomatic Complexity 4 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_get_mw_count
   Cyclomatic Complexity 4 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_get_mw_name
   Cyclomatic Complexity 1 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_db_valid_mask
   Cyclomatic Complexity 1 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_msg_count
   Cyclomatic Complexity 1 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_msg_inbits
   Cyclomatic Complexity 1 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_msg_outbits
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_pci_driver_init
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_deinit_dbgfs
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_unregister_device
   Cyclomatic Complexity 5 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_nt_read
   Cyclomatic Complexity 5 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_nt_write
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_deinit_isr
   Cyclomatic Complexity 3 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_local_link_is_up
   Cyclomatic Complexity 5 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_sw_write
   Cyclomatic Complexity 1 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_local_link_disable
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_deinit_link
   Cyclomatic Complexity 1 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_local_link_enable
   Cyclomatic Complexity 5 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_sw_read
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_read_temp
   Cyclomatic Complexity 4 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_peer_link_is_up
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_deinit_pci
   Cyclomatic Complexity 1 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_pci_remove
   Cyclomatic Complexity 6 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_check_setup
   Cyclomatic Complexity 3 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_create_dev
   Cyclomatic Complexity 3 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_init_link
   Cyclomatic Complexity 3 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_init_msg
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_temp_isr
   Cyclomatic Complexity 10 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_init_pci
   Cyclomatic Complexity 9 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_scan_ports
   Cyclomatic Complexity 10 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_scan_mws
   Cyclomatic Complexity 5 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_init_mws
   Cyclomatic Complexity 5 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_init_isr
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_msg_isr
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_db_isr
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_se_isr
   Cyclomatic Complexity 6 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_thread_isr
   Cyclomatic Complexity 3 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_register_device
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_msg_clear_mask
   Cyclomatic Complexity 5 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_msg_read
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_port_number
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_msg_clear_sts
   Cyclomatic Complexity 9 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_mw_get_align
   Cyclomatic Complexity 5 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_peer_msg_write
   Cyclomatic Complexity 3 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_link_disable
   Cyclomatic Complexity 4 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_mw_count
   Cyclomatic Complexity 8 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_peer_mw_clear_trans
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_db_read
   Cyclomatic Complexity 11 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_peer_mw_set_trans
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_peer_port_count
   Cyclomatic Complexity 3 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_peer_db_set
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_db_clear_mask
   Cyclomatic Complexity 6 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_peer_mw_get_addr
   Cyclomatic Complexity 4 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_peer_port_number
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_peer_mw_count
   Cyclomatic Complexity 3 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_peer_port_idx
   Cyclomatic Complexity 8 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_link_is_up
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_db_set_mask
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_db_read_mask
   Cyclomatic Complexity 2 drivers/ntb/hw/idt/ntb_hw_idt.c:idt_ntb_msg_read_sts
--
   In file included from drivers/nvmem/core.c:22:0:
>> include/linux/module.h:794:13: warning: 'struct tracepoint' declared inside parameter list
         struct tracepoint * const *tp);
                ^
>> include/linux/module.h:794:13: warning: its scope is only this definition or declaration, which is probably not what you want
   Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls64
   Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u64
   Cyclomatic Complexity 1 include/linux/list.h:__list_add_valid
   Cyclomatic Complexity 1 include/linux/list.h:__list_del_entry_valid
   Cyclomatic Complexity 2 include/linux/list.h:__list_add
   Cyclomatic Complexity 1 include/linux/list.h:list_add_tail
   Cyclomatic Complexity 1 include/linux/list.h:__list_del
   Cyclomatic Complexity 2 include/linux/list.h:__list_del_entry
   Cyclomatic Complexity 1 include/linux/list.h:list_del
   Cyclomatic Complexity 1 include/linux/err.h:ERR_PTR
   Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
   Cyclomatic Complexity 1 include/linux/err.h:IS_ERR
   Cyclomatic Complexity 1 include/linux/err.h:ERR_CAST
   Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
   Cyclomatic Complexity 1 include/linux/device.h:devres_alloc
   Cyclomatic Complexity 1 include/linux/module.h:module_is_live
   Cyclomatic Complexity 3 include/linux/module.h:try_module_get
   Cyclomatic Complexity 1 include/linux/module.h:module_put
   Cyclomatic Complexity 1 include/linux/nvmem-consumer.h:of_nvmem_cell_get
   Cyclomatic Complexity 1 include/linux/nvmem-consumer.h:of_nvmem_device_get
   Cyclomatic Complexity 1 include/linux/kasan.h:kasan_kmalloc
   Cyclomatic Complexity 28 include/linux/slab.h:kmalloc_index
   Cyclomatic Complexity 1 include/linux/slab.h:kmem_cache_alloc_trace
   Cyclomatic Complexity 1 include/linux/slab.h:kmalloc_order_trace
   Cyclomatic Complexity 68 include/linux/slab.h:kmalloc_large
   Cyclomatic Complexity 5 include/linux/slab.h:kmalloc
   Cyclomatic Complexity 5 include/linux/slab.h:kmalloc_array
   Cyclomatic Complexity 1 include/linux/slab.h:kcalloc
   Cyclomatic Complexity 1 include/linux/slab.h:kzalloc
   Cyclomatic Complexity 2 drivers/nvmem/core.c:nvmem_reg_read
   Cyclomatic Complexity 2 drivers/nvmem/core.c:nvmem_reg_write
   Cyclomatic Complexity 1 drivers/nvmem/core.c:of_nvmem_match
   Cyclomatic Complexity 1 drivers/nvmem/core.c:devm_nvmem_match
   Cyclomatic Complexity 4 drivers/nvmem/core.c:nvmem_shift_read_buffer_in_place
   Cyclomatic Complexity 4 drivers/nvmem/core.c:__nvmem_cell_read
   Cyclomatic Complexity 3 drivers/nvmem/core.c:nvmem_device_read
   Cyclomatic Complexity 3 drivers/nvmem/core.c:nvmem_device_write
   Cyclomatic Complexity 4 drivers/nvmem/core.c:nvmem_cell_read
   Cyclomatic Complexity 5 drivers/nvmem/core.c:devm_nvmem_device_match
   Cyclomatic Complexity 5 drivers/nvmem/core.c:devm_nvmem_cell_match
   Cyclomatic Complexity 8 drivers/nvmem/core.c:bin_attr_nvmem_write
   Cyclomatic Complexity 8 drivers/nvmem/core.c:bin_attr_nvmem_read
   Cyclomatic Complexity 2 drivers/nvmem/core.c:nvmem_release
   Cyclomatic Complexity 4 drivers/nvmem/core.c:nvmem_setup_compat
   Cyclomatic Complexity 3 drivers/nvmem/core.c:nvmem_cell_info_to_nvmem_cell
   Cyclomatic Complexity 4 drivers/nvmem/core.c:nvmem_device_cell_read
   Cyclomatic Complexity 1 drivers/nvmem/core.c:nvmem_cell_add
   Cyclomatic Complexity 1 drivers/nvmem/core.c:nvmem_cell_drop
   Cyclomatic Complexity 6 drivers/nvmem/core.c:nvmem_add_cells
   Cyclomatic Complexity 20 drivers/nvmem/core.c:nvmem_register
   Cyclomatic Complexity 1 drivers/nvmem/core.c:__nvmem_device_put
   Cyclomatic Complexity 1 drivers/nvmem/core.c:nvmem_device_put
   Cyclomatic Complexity 1 drivers/nvmem/core.c:devm_nvmem_device_release
   Cyclomatic Complexity 1 drivers/nvmem/core.c:nvmem_cell_put
   Cyclomatic Complexity 1 drivers/nvmem/core.c:devm_nvmem_cell_release
   Cyclomatic Complexity 4 drivers/nvmem/core.c:nvmem_device_remove_all_cells
   Cyclomatic Complexity 3 drivers/nvmem/core.c:nvmem_unregister
   Cyclomatic Complexity 2 drivers/nvmem/core.c:devm_nvmem_release
   Cyclomatic Complexity 3 drivers/nvmem/core.c:devm_nvmem_register
   Cyclomatic Complexity 1 drivers/nvmem/core.c:devm_nvmem_unregister
   Cyclomatic Complexity 2 drivers/nvmem/core.c:devm_nvmem_device_put
   Cyclomatic Complexity 2 drivers/nvmem/core.c:devm_nvmem_cell_put
   Cyclomatic Complexity 3 drivers/nvmem/core.c:nvmem_find
   Cyclomatic Complexity 4 drivers/nvmem/core.c:nvmem_device_get
   Cyclomatic Complexity 3 drivers/nvmem/core.c:devm_nvmem_device_get
   Cyclomatic Complexity 4 drivers/nvmem/core.c:of_nvmem_find
   Cyclomatic Complexity 5 drivers/nvmem/core.c:nvmem_find_cell
   Cyclomatic Complexity 6 drivers/nvmem/core.c:__nvmem_device_get
   Cyclomatic Complexity 2 drivers/nvmem/core.c:nvmem_cell_get_from_list
   Cyclomatic Complexity 4 drivers/nvmem/core.c:nvmem_cell_get
   Cyclomatic Complexity 3 drivers/nvmem/core.c:devm_nvmem_cell_get
   Cyclomatic Complexity 4 drivers/nvmem/core.c:nvmem_cell_read_u32
   Cyclomatic Complexity 5 drivers/nvmem/core.c:nvmem_cell_prepare_write_buffer
   Cyclomatic Complexity 9 drivers/nvmem/core.c:nvmem_cell_write
   Cyclomatic Complexity 3 drivers/nvmem/core.c:nvmem_device_cell_write
   Cyclomatic Complexity 1 drivers/nvmem/core.c:nvmem_exit
   Cyclomatic Complexity 1 drivers/nvmem/core.c:nvmem_init
..

vim +/module_layout +4378 kernel/module.c

^1da177e Linus Torvalds    2005-04-16  4374  
^1da177e Linus Torvalds    2005-04-16  4375  #ifdef CONFIG_MODVERSIONS
8c8ef42a Rusty Russell     2009-03-31  4376  /* Generate the signature for all relevant module structures here.
8c8ef42a Rusty Russell     2009-03-31  4377   * If these change, we don't want to try to parse the module. */
8c8ef42a Rusty Russell     2009-03-31 @4378  void module_layout(struct module *mod,
8c8ef42a Rusty Russell     2009-03-31  4379  		   struct modversion_info *ver,
8c8ef42a Rusty Russell     2009-03-31  4380  		   struct kernel_param *kp,
8c8ef42a Rusty Russell     2009-03-31  4381  		   struct kernel_symbol *ks,
65498646 Mathieu Desnoyers 2011-01-26  4382  		   struct tracepoint * const *tp)
8c8ef42a Rusty Russell     2009-03-31  4383  {
8c8ef42a Rusty Russell     2009-03-31  4384  }
8c8ef42a Rusty Russell     2009-03-31 @4385  EXPORT_SYMBOL(module_layout);

:::::: The code at line 4378 was first introduced by commit
:::::: 8c8ef42aee8fcfb4128bb94c50d55c9f80ade525 module: include other structures in module version check

:::::: TO: Rusty Russell <rusty@rustcorp.com.au>
:::::: CC: Rusty Russell <rusty@rustcorp.com.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--BXVAT5kNtrzKuDFl
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--BXVAT5kNtrzKuDFl--

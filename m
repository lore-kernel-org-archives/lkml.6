Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97442C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3842220821
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfBCQEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 11:04:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:29044 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbfBCQEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 11:04:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2019 08:04:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,556,1539673200"; 
   d="gz'50?scan'50,208,50";a="141224299"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2019 08:04:26 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gqKFu-000COe-B1; Mon, 04 Feb 2019 00:04:26 +0800
Date:   Mon, 4 Feb 2019 00:04:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] device.h: Add __cold to dev_<level> logging functions
Message-ID: <201902040059.IqLvyYFo%fengguang.wu@intel.com>
References: <f0737d2d4ba1ccbe0e5054d8dad9bb6385fda91f.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <f0737d2d4ba1ccbe0e5054d8dad9bb6385fda91f.camel@perches.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Joe,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.0-rc4 next-20190201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Joe-Perches/device-h-Add-__cold-to-dev_-level-logging-functions/20190203-211040
config: i386-randconfig-c0-01290401 (attached as .config)
compiler: gcc-8 (Debian 8.2.0-14) 8.2.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/staging/axis-fifo/axis-fifo.c: In function 'axis_fifo_probe':
   drivers/staging/axis-fifo/axis-fifo.c:900:5: warning: 'rxd_tdata_width' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (rxd_tdata_width != 32) {
        ^
>> drivers/staging/axis-fifo/axis-fifo.c:907:5: warning: 'txd_tdata_width' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (txd_tdata_width != 32) {
        ^
   drivers/staging/axis-fifo/axis-fifo.c:914:5: warning: 'has_tdest' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (has_tdest) {
        ^
>> drivers/staging/axis-fifo/axis-fifo.c:919:5: warning: 'has_tid' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (has_tid) {
        ^
>> drivers/staging/axis-fifo/axis-fifo.c:924:5: warning: 'has_tkeep' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (has_tkeep) {
        ^
>> drivers/staging/axis-fifo/axis-fifo.c:929:5: warning: 'has_tstrb' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (has_tstrb) {
        ^
>> drivers/staging/axis-fifo/axis-fifo.c:934:5: warning: 'has_tuser' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (has_tuser) {
        ^
>> drivers/staging/axis-fifo/axis-fifo.c:939:5: warning: 'use_rx_cut_through' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (use_rx_cut_through) {
        ^
>> drivers/staging/axis-fifo/axis-fifo.c:944:5: warning: 'use_tx_cut_through' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (use_tx_cut_through) {
        ^
>> drivers/staging/axis-fifo/axis-fifo.c:949:5: warning: 'use_tx_control' may be used uninitialized in this function [-Wmaybe-uninitialized]
     if (use_tx_control) {
        ^
   drivers/staging/axis-fifo/axis-fifo.c:962:22: warning: 'rx_fifo_depth' may be used uninitialized in this function [-Wmaybe-uninitialized]
     fifo->rx_fifo_depth = rx_fifo_depth;
     ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
   drivers/staging/axis-fifo/axis-fifo.c:964:38: warning: 'tx_fifo_depth' may be used uninitialized in this function [-Wmaybe-uninitialized]
     fifo->tx_fifo_depth = tx_fifo_depth - 4;
                           ~~~~~~~~~~~~~~^~~
   drivers/staging/axis-fifo/axis-fifo.c:965:20: warning: 'use_rx_data' may be used uninitialized in this function [-Wmaybe-uninitialized]
     fifo->has_rx_fifo = use_rx_data;
     ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
   drivers/staging/axis-fifo/axis-fifo.c:966:20: warning: 'use_tx_data' may be used uninitialized in this function [-Wmaybe-uninitialized]
     fifo->has_tx_fifo = use_tx_data;
     ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~

vim +/txd_tdata_width +907 drivers/staging/axis-fifo/axis-fifo.c

4a965c5f8 Jacob Feder 2018-07-22   703  
4a965c5f8 Jacob Feder 2018-07-22   704  static int axis_fifo_probe(struct platform_device *pdev)
4a965c5f8 Jacob Feder 2018-07-22   705  {
4a965c5f8 Jacob Feder 2018-07-22   706  	struct resource *r_irq; /* interrupt resources */
4a965c5f8 Jacob Feder 2018-07-22   707  	struct resource *r_mem; /* IO mem resources */
4a965c5f8 Jacob Feder 2018-07-22   708  	struct device *dev = &pdev->dev; /* OS device (from device tree) */
4a965c5f8 Jacob Feder 2018-07-22   709  	struct axis_fifo *fifo = NULL;
4a965c5f8 Jacob Feder 2018-07-22   710  
4a965c5f8 Jacob Feder 2018-07-22   711  	char device_name[32];
4a965c5f8 Jacob Feder 2018-07-22   712  
4a965c5f8 Jacob Feder 2018-07-22   713  	int rc = 0; /* error return value */
4a965c5f8 Jacob Feder 2018-07-22   714  
4a965c5f8 Jacob Feder 2018-07-22   715  	/* IP properties from device tree */
4a965c5f8 Jacob Feder 2018-07-22   716  	unsigned int rxd_tdata_width;
4a965c5f8 Jacob Feder 2018-07-22   717  	unsigned int txc_tdata_width;
4a965c5f8 Jacob Feder 2018-07-22   718  	unsigned int txd_tdata_width;
4a965c5f8 Jacob Feder 2018-07-22   719  	unsigned int tdest_width;
4a965c5f8 Jacob Feder 2018-07-22   720  	unsigned int tid_width;
4a965c5f8 Jacob Feder 2018-07-22   721  	unsigned int tuser_width;
4a965c5f8 Jacob Feder 2018-07-22   722  	unsigned int data_interface_type;
4a965c5f8 Jacob Feder 2018-07-22   723  	unsigned int has_tdest;
4a965c5f8 Jacob Feder 2018-07-22   724  	unsigned int has_tid;
4a965c5f8 Jacob Feder 2018-07-22   725  	unsigned int has_tkeep;
4a965c5f8 Jacob Feder 2018-07-22   726  	unsigned int has_tstrb;
4a965c5f8 Jacob Feder 2018-07-22   727  	unsigned int has_tuser;
4a965c5f8 Jacob Feder 2018-07-22   728  	unsigned int rx_fifo_depth;
4a965c5f8 Jacob Feder 2018-07-22   729  	unsigned int rx_programmable_empty_threshold;
4a965c5f8 Jacob Feder 2018-07-22   730  	unsigned int rx_programmable_full_threshold;
4a965c5f8 Jacob Feder 2018-07-22   731  	unsigned int axi_id_width;
4a965c5f8 Jacob Feder 2018-07-22   732  	unsigned int axi4_data_width;
4a965c5f8 Jacob Feder 2018-07-22   733  	unsigned int select_xpm;
4a965c5f8 Jacob Feder 2018-07-22   734  	unsigned int tx_fifo_depth;
4a965c5f8 Jacob Feder 2018-07-22   735  	unsigned int tx_programmable_empty_threshold;
4a965c5f8 Jacob Feder 2018-07-22   736  	unsigned int tx_programmable_full_threshold;
4a965c5f8 Jacob Feder 2018-07-22   737  	unsigned int use_rx_cut_through;
4a965c5f8 Jacob Feder 2018-07-22   738  	unsigned int use_rx_data;
4a965c5f8 Jacob Feder 2018-07-22   739  	unsigned int use_tx_control;
4a965c5f8 Jacob Feder 2018-07-22   740  	unsigned int use_tx_cut_through;
4a965c5f8 Jacob Feder 2018-07-22   741  	unsigned int use_tx_data;
4a965c5f8 Jacob Feder 2018-07-22   742  
4a965c5f8 Jacob Feder 2018-07-22   743  	/* ----------------------------
4a965c5f8 Jacob Feder 2018-07-22   744  	 *     init wrapper device
4a965c5f8 Jacob Feder 2018-07-22   745  	 * ----------------------------
4a965c5f8 Jacob Feder 2018-07-22   746  	 */
4a965c5f8 Jacob Feder 2018-07-22   747  
4a965c5f8 Jacob Feder 2018-07-22   748  	/* allocate device wrapper memory */
4a965c5f8 Jacob Feder 2018-07-22   749  	fifo = devm_kmalloc(dev, sizeof(*fifo), GFP_KERNEL);
4a965c5f8 Jacob Feder 2018-07-22   750  	if (!fifo)
4a965c5f8 Jacob Feder 2018-07-22   751  		return -ENOMEM;
4a965c5f8 Jacob Feder 2018-07-22   752  
4a965c5f8 Jacob Feder 2018-07-22   753  	dev_set_drvdata(dev, fifo);
4a965c5f8 Jacob Feder 2018-07-22   754  	fifo->dt_device = dev;
4a965c5f8 Jacob Feder 2018-07-22   755  
4a965c5f8 Jacob Feder 2018-07-22   756  	init_waitqueue_head(&fifo->read_queue);
4a965c5f8 Jacob Feder 2018-07-22   757  	init_waitqueue_head(&fifo->write_queue);
4a965c5f8 Jacob Feder 2018-07-22   758  
4a965c5f8 Jacob Feder 2018-07-22   759  	spin_lock_init(&fifo->read_queue_lock);
4a965c5f8 Jacob Feder 2018-07-22   760  	spin_lock_init(&fifo->write_queue_lock);
4a965c5f8 Jacob Feder 2018-07-22   761  
4a965c5f8 Jacob Feder 2018-07-22   762  	/* ----------------------------
4a965c5f8 Jacob Feder 2018-07-22   763  	 *   init device memory space
4a965c5f8 Jacob Feder 2018-07-22   764  	 * ----------------------------
4a965c5f8 Jacob Feder 2018-07-22   765  	 */
4a965c5f8 Jacob Feder 2018-07-22   766  
4a965c5f8 Jacob Feder 2018-07-22   767  	/* get iospace for the device */
4a965c5f8 Jacob Feder 2018-07-22   768  	r_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
4a965c5f8 Jacob Feder 2018-07-22   769  	if (!r_mem) {
4a965c5f8 Jacob Feder 2018-07-22   770  		dev_err(fifo->dt_device, "invalid address\n");
4a965c5f8 Jacob Feder 2018-07-22   771  		rc = -ENODEV;
4a965c5f8 Jacob Feder 2018-07-22   772  		goto err_initial;
4a965c5f8 Jacob Feder 2018-07-22   773  	}
4a965c5f8 Jacob Feder 2018-07-22   774  
4a965c5f8 Jacob Feder 2018-07-22   775  	fifo->mem = r_mem;
4a965c5f8 Jacob Feder 2018-07-22   776  
4a965c5f8 Jacob Feder 2018-07-22   777  	/* request physical memory */
4a965c5f8 Jacob Feder 2018-07-22   778  	if (!request_mem_region(fifo->mem->start, resource_size(fifo->mem),
4a965c5f8 Jacob Feder 2018-07-22   779  				DRIVER_NAME)) {
4a965c5f8 Jacob Feder 2018-07-22   780  		dev_err(fifo->dt_device,
4a965c5f8 Jacob Feder 2018-07-22   781  			"couldn't lock memory region at 0x%pa\n",
4a965c5f8 Jacob Feder 2018-07-22   782  			&fifo->mem->start);
4a965c5f8 Jacob Feder 2018-07-22   783  		rc = -EBUSY;
4a965c5f8 Jacob Feder 2018-07-22   784  		goto err_initial;
4a965c5f8 Jacob Feder 2018-07-22   785  	}
4a965c5f8 Jacob Feder 2018-07-22   786  	dev_dbg(fifo->dt_device, "got memory location [0x%pa - 0x%pa]\n",
4a965c5f8 Jacob Feder 2018-07-22   787  		&fifo->mem->start, &fifo->mem->end);
4a965c5f8 Jacob Feder 2018-07-22   788  
4a965c5f8 Jacob Feder 2018-07-22   789  	/* map physical memory to kernel virtual address space */
4a965c5f8 Jacob Feder 2018-07-22   790  	fifo->base_addr = ioremap(fifo->mem->start, resource_size(fifo->mem));
4a965c5f8 Jacob Feder 2018-07-22   791  	if (!fifo->base_addr) {
4a965c5f8 Jacob Feder 2018-07-22   792  		dev_err(fifo->dt_device, "couldn't map physical memory\n");
4a965c5f8 Jacob Feder 2018-07-22   793  		rc = -ENOMEM;
4a965c5f8 Jacob Feder 2018-07-22   794  		goto err_mem;
4a965c5f8 Jacob Feder 2018-07-22   795  	}
4a965c5f8 Jacob Feder 2018-07-22   796  	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
4a965c5f8 Jacob Feder 2018-07-22   797  
4a965c5f8 Jacob Feder 2018-07-22   798  	/* create unique device name */
4a965c5f8 Jacob Feder 2018-07-22   799  	snprintf(device_name, sizeof(device_name), "%s_%pa",
4a965c5f8 Jacob Feder 2018-07-22   800  		 DRIVER_NAME, &fifo->mem->start);
4a965c5f8 Jacob Feder 2018-07-22   801  
4a965c5f8 Jacob Feder 2018-07-22   802  	dev_dbg(fifo->dt_device, "device name [%s]\n", device_name);
4a965c5f8 Jacob Feder 2018-07-22   803  
4a965c5f8 Jacob Feder 2018-07-22   804  	/* ----------------------------
4a965c5f8 Jacob Feder 2018-07-22   805  	 *          init IP
4a965c5f8 Jacob Feder 2018-07-22   806  	 * ----------------------------
4a965c5f8 Jacob Feder 2018-07-22   807  	 */
4a965c5f8 Jacob Feder 2018-07-22   808  
4a965c5f8 Jacob Feder 2018-07-22   809  	/* retrieve device tree properties */
4a965c5f8 Jacob Feder 2018-07-22   810  	rc = get_dts_property(fifo, "xlnx,axi-str-rxd-tdata-width",
4a965c5f8 Jacob Feder 2018-07-22   811  			      &rxd_tdata_width);
4a965c5f8 Jacob Feder 2018-07-22   812  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   813  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   814  	rc = get_dts_property(fifo, "xlnx,axi-str-txc-tdata-width",
4a965c5f8 Jacob Feder 2018-07-22   815  			      &txc_tdata_width);
4a965c5f8 Jacob Feder 2018-07-22   816  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   817  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   818  	rc = get_dts_property(fifo, "xlnx,axi-str-txd-tdata-width",
4a965c5f8 Jacob Feder 2018-07-22   819  			      &txd_tdata_width);
4a965c5f8 Jacob Feder 2018-07-22   820  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   821  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   822  	rc = get_dts_property(fifo, "xlnx,axis-tdest-width", &tdest_width);
4a965c5f8 Jacob Feder 2018-07-22   823  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   824  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   825  	rc = get_dts_property(fifo, "xlnx,axis-tid-width", &tid_width);
4a965c5f8 Jacob Feder 2018-07-22   826  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   827  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   828  	rc = get_dts_property(fifo, "xlnx,axis-tuser-width", &tuser_width);
4a965c5f8 Jacob Feder 2018-07-22   829  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   830  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   831  	rc = get_dts_property(fifo, "xlnx,data-interface-type",
4a965c5f8 Jacob Feder 2018-07-22   832  			      &data_interface_type);
4a965c5f8 Jacob Feder 2018-07-22   833  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   834  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   835  	rc = get_dts_property(fifo, "xlnx,has-axis-tdest", &has_tdest);
4a965c5f8 Jacob Feder 2018-07-22   836  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   837  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   838  	rc = get_dts_property(fifo, "xlnx,has-axis-tid", &has_tid);
4a965c5f8 Jacob Feder 2018-07-22   839  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   840  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   841  	rc = get_dts_property(fifo, "xlnx,has-axis-tkeep", &has_tkeep);
4a965c5f8 Jacob Feder 2018-07-22   842  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   843  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   844  	rc = get_dts_property(fifo, "xlnx,has-axis-tstrb", &has_tstrb);
4a965c5f8 Jacob Feder 2018-07-22   845  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   846  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   847  	rc = get_dts_property(fifo, "xlnx,has-axis-tuser", &has_tuser);
4a965c5f8 Jacob Feder 2018-07-22   848  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   849  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   850  	rc = get_dts_property(fifo, "xlnx,rx-fifo-depth", &rx_fifo_depth);
4a965c5f8 Jacob Feder 2018-07-22   851  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   852  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   853  	rc = get_dts_property(fifo, "xlnx,rx-fifo-pe-threshold",
4a965c5f8 Jacob Feder 2018-07-22   854  			      &rx_programmable_empty_threshold);
4a965c5f8 Jacob Feder 2018-07-22   855  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   856  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   857  	rc = get_dts_property(fifo, "xlnx,rx-fifo-pf-threshold",
4a965c5f8 Jacob Feder 2018-07-22   858  			      &rx_programmable_full_threshold);
4a965c5f8 Jacob Feder 2018-07-22   859  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   860  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   861  	rc = get_dts_property(fifo, "xlnx,s-axi-id-width", &axi_id_width);
4a965c5f8 Jacob Feder 2018-07-22   862  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   863  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   864  	rc = get_dts_property(fifo, "xlnx,s-axi4-data-width", &axi4_data_width);
4a965c5f8 Jacob Feder 2018-07-22   865  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   866  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   867  	rc = get_dts_property(fifo, "xlnx,select-xpm", &select_xpm);
4a965c5f8 Jacob Feder 2018-07-22   868  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   869  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   870  	rc = get_dts_property(fifo, "xlnx,tx-fifo-depth", &tx_fifo_depth);
4a965c5f8 Jacob Feder 2018-07-22   871  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   872  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   873  	rc = get_dts_property(fifo, "xlnx,tx-fifo-pe-threshold",
4a965c5f8 Jacob Feder 2018-07-22   874  			      &tx_programmable_empty_threshold);
4a965c5f8 Jacob Feder 2018-07-22   875  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   876  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   877  	rc = get_dts_property(fifo, "xlnx,tx-fifo-pf-threshold",
4a965c5f8 Jacob Feder 2018-07-22   878  			      &tx_programmable_full_threshold);
4a965c5f8 Jacob Feder 2018-07-22   879  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   880  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   881  	rc = get_dts_property(fifo, "xlnx,use-rx-cut-through",
4a965c5f8 Jacob Feder 2018-07-22   882  			      &use_rx_cut_through);
4a965c5f8 Jacob Feder 2018-07-22   883  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   884  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   885  	rc = get_dts_property(fifo, "xlnx,use-rx-data", &use_rx_data);
4a965c5f8 Jacob Feder 2018-07-22   886  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   887  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   888  	rc = get_dts_property(fifo, "xlnx,use-tx-ctrl", &use_tx_control);
4a965c5f8 Jacob Feder 2018-07-22   889  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   890  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   891  	rc = get_dts_property(fifo, "xlnx,use-tx-cut-through",
4a965c5f8 Jacob Feder 2018-07-22   892  			      &use_tx_cut_through);
4a965c5f8 Jacob Feder 2018-07-22   893  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   894  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   895  	rc = get_dts_property(fifo, "xlnx,use-tx-data", &use_tx_data);
4a965c5f8 Jacob Feder 2018-07-22   896  	if (rc)
4a965c5f8 Jacob Feder 2018-07-22   897  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   898  
4a965c5f8 Jacob Feder 2018-07-22   899  	/* check validity of device tree properties */
4a965c5f8 Jacob Feder 2018-07-22  @900  	if (rxd_tdata_width != 32) {
4a965c5f8 Jacob Feder 2018-07-22   901  		dev_err(fifo->dt_device,
4a965c5f8 Jacob Feder 2018-07-22   902  			"rxd_tdata_width width [%u] unsupported\n",
4a965c5f8 Jacob Feder 2018-07-22   903  			rxd_tdata_width);
4a965c5f8 Jacob Feder 2018-07-22   904  		rc = -EIO;
4a965c5f8 Jacob Feder 2018-07-22   905  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   906  	}
4a965c5f8 Jacob Feder 2018-07-22  @907  	if (txd_tdata_width != 32) {
4a965c5f8 Jacob Feder 2018-07-22   908  		dev_err(fifo->dt_device,
4a965c5f8 Jacob Feder 2018-07-22   909  			"txd_tdata_width width [%u] unsupported\n",
4a965c5f8 Jacob Feder 2018-07-22   910  			txd_tdata_width);
4a965c5f8 Jacob Feder 2018-07-22   911  		rc = -EIO;
4a965c5f8 Jacob Feder 2018-07-22   912  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   913  	}
4a965c5f8 Jacob Feder 2018-07-22  @914  	if (has_tdest) {
4a965c5f8 Jacob Feder 2018-07-22   915  		dev_err(fifo->dt_device, "tdest not supported\n");
4a965c5f8 Jacob Feder 2018-07-22   916  		rc = -EIO;
4a965c5f8 Jacob Feder 2018-07-22   917  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   918  	}
4a965c5f8 Jacob Feder 2018-07-22  @919  	if (has_tid) {
4a965c5f8 Jacob Feder 2018-07-22   920  		dev_err(fifo->dt_device, "tid not supported\n");
4a965c5f8 Jacob Feder 2018-07-22   921  		rc = -EIO;
4a965c5f8 Jacob Feder 2018-07-22   922  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   923  	}
4a965c5f8 Jacob Feder 2018-07-22  @924  	if (has_tkeep) {
4a965c5f8 Jacob Feder 2018-07-22   925  		dev_err(fifo->dt_device, "tkeep not supported\n");
4a965c5f8 Jacob Feder 2018-07-22   926  		rc = -EIO;
4a965c5f8 Jacob Feder 2018-07-22   927  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   928  	}
4a965c5f8 Jacob Feder 2018-07-22  @929  	if (has_tstrb) {
4a965c5f8 Jacob Feder 2018-07-22   930  		dev_err(fifo->dt_device, "tstrb not supported\n");
4a965c5f8 Jacob Feder 2018-07-22   931  		rc = -EIO;
4a965c5f8 Jacob Feder 2018-07-22   932  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   933  	}
4a965c5f8 Jacob Feder 2018-07-22  @934  	if (has_tuser) {
4a965c5f8 Jacob Feder 2018-07-22   935  		dev_err(fifo->dt_device, "tuser not supported\n");
4a965c5f8 Jacob Feder 2018-07-22   936  		rc = -EIO;
4a965c5f8 Jacob Feder 2018-07-22   937  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   938  	}
4a965c5f8 Jacob Feder 2018-07-22  @939  	if (use_rx_cut_through) {
4a965c5f8 Jacob Feder 2018-07-22   940  		dev_err(fifo->dt_device, "rx cut-through not supported\n");
4a965c5f8 Jacob Feder 2018-07-22   941  		rc = -EIO;
4a965c5f8 Jacob Feder 2018-07-22   942  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   943  	}
4a965c5f8 Jacob Feder 2018-07-22  @944  	if (use_tx_cut_through) {
4a965c5f8 Jacob Feder 2018-07-22   945  		dev_err(fifo->dt_device, "tx cut-through not supported\n");
4a965c5f8 Jacob Feder 2018-07-22   946  		rc = -EIO;
4a965c5f8 Jacob Feder 2018-07-22   947  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   948  	}
4a965c5f8 Jacob Feder 2018-07-22  @949  	if (use_tx_control) {
4a965c5f8 Jacob Feder 2018-07-22   950  		dev_err(fifo->dt_device, "tx control not supported\n");
4a965c5f8 Jacob Feder 2018-07-22   951  		rc = -EIO;
4a965c5f8 Jacob Feder 2018-07-22   952  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   953  	}
4a965c5f8 Jacob Feder 2018-07-22   954  
4a965c5f8 Jacob Feder 2018-07-22   955  	/* TODO
4a965c5f8 Jacob Feder 2018-07-22   956  	 * these exist in the device tree but it's unclear what they do
4a965c5f8 Jacob Feder 2018-07-22   957  	 * - select-xpm
4a965c5f8 Jacob Feder 2018-07-22   958  	 * - data-interface-type
4a965c5f8 Jacob Feder 2018-07-22   959  	 */
4a965c5f8 Jacob Feder 2018-07-22   960  
4a965c5f8 Jacob Feder 2018-07-22   961  	/* set device wrapper properties based on IP config */
4a965c5f8 Jacob Feder 2018-07-22   962  	fifo->rx_fifo_depth = rx_fifo_depth;
4a965c5f8 Jacob Feder 2018-07-22   963  	/* IP sets TDFV to fifo depth - 4 so we will do the same */
4a965c5f8 Jacob Feder 2018-07-22   964  	fifo->tx_fifo_depth = tx_fifo_depth - 4;
4a965c5f8 Jacob Feder 2018-07-22   965  	fifo->has_rx_fifo = use_rx_data;
4a965c5f8 Jacob Feder 2018-07-22   966  	fifo->has_tx_fifo = use_tx_data;
4a965c5f8 Jacob Feder 2018-07-22   967  
4a965c5f8 Jacob Feder 2018-07-22   968  	reset_ip_core(fifo);
4a965c5f8 Jacob Feder 2018-07-22   969  
4a965c5f8 Jacob Feder 2018-07-22   970  	/* ----------------------------
4a965c5f8 Jacob Feder 2018-07-22   971  	 *    init device interrupts
4a965c5f8 Jacob Feder 2018-07-22   972  	 * ----------------------------
4a965c5f8 Jacob Feder 2018-07-22   973  	 */
4a965c5f8 Jacob Feder 2018-07-22   974  
4a965c5f8 Jacob Feder 2018-07-22   975  	/* get IRQ resource */
4a965c5f8 Jacob Feder 2018-07-22   976  	r_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
4a965c5f8 Jacob Feder 2018-07-22   977  	if (!r_irq) {
4a965c5f8 Jacob Feder 2018-07-22   978  		dev_err(fifo->dt_device, "no IRQ found for 0x%pa\n",
4a965c5f8 Jacob Feder 2018-07-22   979  			&fifo->mem->start);
4a965c5f8 Jacob Feder 2018-07-22   980  		rc = -EIO;
4a965c5f8 Jacob Feder 2018-07-22   981  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   982  	}
4a965c5f8 Jacob Feder 2018-07-22   983  
4a965c5f8 Jacob Feder 2018-07-22   984  	/* request IRQ */
4a965c5f8 Jacob Feder 2018-07-22   985  	fifo->irq = r_irq->start;
4a965c5f8 Jacob Feder 2018-07-22   986  	rc = request_irq(fifo->irq, &axis_fifo_irq, 0, DRIVER_NAME, fifo);
4a965c5f8 Jacob Feder 2018-07-22   987  	if (rc) {
4a965c5f8 Jacob Feder 2018-07-22   988  		dev_err(fifo->dt_device, "couldn't allocate interrupt %i\n",
4a965c5f8 Jacob Feder 2018-07-22   989  			fifo->irq);
4a965c5f8 Jacob Feder 2018-07-22   990  		goto err_unmap;
4a965c5f8 Jacob Feder 2018-07-22   991  	}
4a965c5f8 Jacob Feder 2018-07-22   992  
4a965c5f8 Jacob Feder 2018-07-22   993  	/* ----------------------------
4a965c5f8 Jacob Feder 2018-07-22   994  	 *      init char device
4a965c5f8 Jacob Feder 2018-07-22   995  	 * ----------------------------
4a965c5f8 Jacob Feder 2018-07-22   996  	 */
4a965c5f8 Jacob Feder 2018-07-22   997  
4a965c5f8 Jacob Feder 2018-07-22   998  	/* allocate device number */
4a965c5f8 Jacob Feder 2018-07-22   999  	rc = alloc_chrdev_region(&fifo->devt, 0, 1, DRIVER_NAME);
4a965c5f8 Jacob Feder 2018-07-22  1000  	if (rc < 0)
4a965c5f8 Jacob Feder 2018-07-22  1001  		goto err_irq;
4a965c5f8 Jacob Feder 2018-07-22  1002  	dev_dbg(fifo->dt_device, "allocated device number major %i minor %i\n",
4a965c5f8 Jacob Feder 2018-07-22  1003  		MAJOR(fifo->devt), MINOR(fifo->devt));
4a965c5f8 Jacob Feder 2018-07-22  1004  
4a965c5f8 Jacob Feder 2018-07-22  1005  	/* create driver file */
4a965c5f8 Jacob Feder 2018-07-22  1006  	fifo->device = device_create(axis_fifo_driver_class, NULL, fifo->devt,
4a965c5f8 Jacob Feder 2018-07-22  1007  				     NULL, device_name);
6d4abf1c0 Wei Yongjun 2018-07-27  1008  	if (IS_ERR(fifo->device)) {
4a965c5f8 Jacob Feder 2018-07-22  1009  		dev_err(fifo->dt_device,
4a965c5f8 Jacob Feder 2018-07-22  1010  			"couldn't create driver file\n");
6d4abf1c0 Wei Yongjun 2018-07-27  1011  		rc = PTR_ERR(fifo->device);
4a965c5f8 Jacob Feder 2018-07-22  1012  		goto err_chrdev_region;
4a965c5f8 Jacob Feder 2018-07-22  1013  	}
4a965c5f8 Jacob Feder 2018-07-22  1014  	dev_set_drvdata(fifo->device, fifo);
4a965c5f8 Jacob Feder 2018-07-22  1015  
4a965c5f8 Jacob Feder 2018-07-22  1016  	/* create character device */
4a965c5f8 Jacob Feder 2018-07-22  1017  	cdev_init(&fifo->char_device, &fops);
4a965c5f8 Jacob Feder 2018-07-22  1018  	rc = cdev_add(&fifo->char_device, fifo->devt, 1);
4a965c5f8 Jacob Feder 2018-07-22  1019  	if (rc < 0) {
4a965c5f8 Jacob Feder 2018-07-22  1020  		dev_err(fifo->dt_device, "couldn't create character device\n");
4a965c5f8 Jacob Feder 2018-07-22  1021  		goto err_dev;
4a965c5f8 Jacob Feder 2018-07-22  1022  	}
4a965c5f8 Jacob Feder 2018-07-22  1023  
4a965c5f8 Jacob Feder 2018-07-22  1024  	/* create sysfs entries */
4a965c5f8 Jacob Feder 2018-07-22  1025  	rc = sysfs_create_group(&fifo->device->kobj, &axis_fifo_attrs_group);
4a965c5f8 Jacob Feder 2018-07-22  1026  	if (rc < 0) {
4a965c5f8 Jacob Feder 2018-07-22  1027  		dev_err(fifo->dt_device, "couldn't register sysfs group\n");
4a965c5f8 Jacob Feder 2018-07-22  1028  		goto err_cdev;
4a965c5f8 Jacob Feder 2018-07-22  1029  	}
4a965c5f8 Jacob Feder 2018-07-22  1030  
4a965c5f8 Jacob Feder 2018-07-22  1031  	dev_info(fifo->dt_device, "axis-fifo created at %pa mapped to 0x%pa, irq=%i, major=%i, minor=%i\n",
4a965c5f8 Jacob Feder 2018-07-22  1032  		 &fifo->mem->start, &fifo->base_addr, fifo->irq,
4a965c5f8 Jacob Feder 2018-07-22  1033  		 MAJOR(fifo->devt), MINOR(fifo->devt));
4a965c5f8 Jacob Feder 2018-07-22  1034  
4a965c5f8 Jacob Feder 2018-07-22  1035  	return 0;
4a965c5f8 Jacob Feder 2018-07-22  1036  
4a965c5f8 Jacob Feder 2018-07-22  1037  err_cdev:
4a965c5f8 Jacob Feder 2018-07-22  1038  	cdev_del(&fifo->char_device);
4a965c5f8 Jacob Feder 2018-07-22  1039  err_dev:
4a965c5f8 Jacob Feder 2018-07-22  1040  	device_destroy(axis_fifo_driver_class, fifo->devt);
4a965c5f8 Jacob Feder 2018-07-22  1041  err_chrdev_region:
4a965c5f8 Jacob Feder 2018-07-22  1042  	unregister_chrdev_region(fifo->devt, 1);
4a965c5f8 Jacob Feder 2018-07-22  1043  err_irq:
4a965c5f8 Jacob Feder 2018-07-22  1044  	free_irq(fifo->irq, fifo);
4a965c5f8 Jacob Feder 2018-07-22  1045  err_unmap:
4a965c5f8 Jacob Feder 2018-07-22  1046  	iounmap(fifo->base_addr);
4a965c5f8 Jacob Feder 2018-07-22  1047  err_mem:
4a965c5f8 Jacob Feder 2018-07-22  1048  	release_mem_region(fifo->mem->start, resource_size(fifo->mem));
4a965c5f8 Jacob Feder 2018-07-22  1049  err_initial:
4a965c5f8 Jacob Feder 2018-07-22  1050  	dev_set_drvdata(dev, NULL);
4a965c5f8 Jacob Feder 2018-07-22  1051  	return rc;
4a965c5f8 Jacob Feder 2018-07-22  1052  }
4a965c5f8 Jacob Feder 2018-07-22  1053  

:::::: The code at line 907 was first introduced by commit
:::::: 4a965c5f89decd636129cddc47e5f2c61e8f13e6 staging: add driver for Xilinx AXI-Stream FIFO v4.1 IP core

:::::: TO: Jacob Feder <jacobsfeder@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--3MwIy2ne0vdjdPXF
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/pgBAA==

--3MwIy2ne0vdjdPXF--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033355AbeE2C6N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 22:58:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:14354 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935511AbeE2C6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 22:58:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,454,1520924400";
   d="scan'208";a="43543053"
Date: Tue, 29 May 2018 10:57:19 +0800
From: kbuild test robot <lkp@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Felipe Balbi <balbi@kernel.org>,
        davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH v2 1/3] usb: gadget: ccid: add support for USB CCID
 Gadget Device
Message-ID: <201805291006.Bwbt8QzN%fengguang.wu@intel.com>
References: <20180526211940.25474-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180526211940.25474-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcus,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on balbi-usb/next]
[also build test WARNING on v4.17-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Marcus-Folkesson/usb-gadget-ccid-add-support-for-USB-CCID-Gadget-Device/20180529-014427
base:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/usb/gadget/function/f_ccid.c:423:43: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [unsigned] [usertype] <noident> @@    got ed int [unsigned] [usertype] <noident> @@
   drivers/usb/gadget/function/f_ccid.c:423:43:    expected unsigned int [unsigned] [usertype] <noident>
   drivers/usb/gadget/function/f_ccid.c:423:43:    got restricted __le32 [usertype] <noident>
>> drivers/usb/gadget/function/f_ccid.c:424:31: sparse: expression using sizeof(void)
   drivers/usb/gadget/function/f_ccid.c:429:43: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [unsigned] [usertype] <noident> @@    got ed int [unsigned] [usertype] <noident> @@
   drivers/usb/gadget/function/f_ccid.c:429:43:    expected unsigned int [unsigned] [usertype] <noident>
   drivers/usb/gadget/function/f_ccid.c:429:43:    got restricted __le32 [usertype] <noident>
   drivers/usb/gadget/function/f_ccid.c:430:31: sparse: expression using sizeof(void)
>> drivers/usb/gadget/function/f_ccid.c:481:5: sparse: symbol 'ccidg_start_ep' was not declared. Should it be static?
>> drivers/usb/gadget/function/f_ccid.c:669:35: sparse: Using plain integer as NULL pointer
>> drivers/usb/gadget/function/f_ccid.c:831:41: sparse: incorrect type in assignment (different base types) @@    expected unsigned int static [unsigned] [addressable] [toplevel] [usertype] dwFeatures @@    got sable] [toplevel] [usertype] dwFeatures @@
   drivers/usb/gadget/function/f_ccid.c:831:41:    expected unsigned int static [unsigned] [addressable] [toplevel] [usertype] dwFeatures
   drivers/usb/gadget/function/f_ccid.c:831:41:    got restricted __le32 [usertype] <noident>
>> drivers/usb/gadget/function/f_ccid.c:833:41: sparse: incorrect type in assignment (different base types) @@    expected unsigned short static [unsigned] [addressable] [toplevel] [assigned] [usertype] wLcdLayout @@    got level] [assigned] [usertype] wLcdLayout @@
   drivers/usb/gadget/function/f_ccid.c:833:41:    expected unsigned short static [unsigned] [addressable] [toplevel] [assigned] [usertype] wLcdLayout
   drivers/usb/gadget/function/f_ccid.c:833:41:    got restricted __le16 [usertype] <noident>
>> drivers/usb/gadget/function/f_ccid.c:835:41: sparse: incorrect type in assignment (different base types) @@    expected unsigned int static [unsigned] [addressable] [toplevel] [assigned] [usertype] dwProtocols @@    got level] [assigned] [usertype] dwProtocols @@
   drivers/usb/gadget/function/f_ccid.c:835:41:    expected unsigned int static [unsigned] [addressable] [toplevel] [assigned] [usertype] dwProtocols
   drivers/usb/gadget/function/f_ccid.c:835:41:    got restricted __le32 [usertype] <noident>
   In file included from include/linux/printk.h:332:0,
                    from include/linux/kernel.h:14,
                    from include/linux/list.h:9,
                    from include/linux/kobject.h:19,
                    from include/linux/cdev.h:5,
                    from drivers/usb/gadget/function/f_ccid.c:8:
   drivers/usb/gadget/function/f_ccid.c: In function 'ccidg_bulk_read':
   drivers/usb/gadget/function/f_ccid.c:612:5: warning: format '%i' expects argument of type 'int', but argument 4 has type 'size_t {aka long unsigned int}' [-Wformat=]
        "ccid: too small buffer size. %i provided, need at least %in",
        ^
   include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, 32-                                       ^~~
   include/linux/usb/composite.h:632:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(&(d)->gadget->dev , fmt , ## args)
     ^~~~~~~
   drivers/usb/gadget/function/f_ccid.c:611:3: note: in expansion of macro 'DBG'
      DBG(ccidg->function.config->cdev,
      ^~~
   drivers/usb/gadget/function/f_ccid.c:612:5: warning: format '%i' expects argument of type 'int', but argument 5 has type 'long unsigned int' [-Wformat=]
        "ccid: too small buffer size. %i provided, need at least %in",
        ^
   include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, 44-                                       ^~~
   include/linux/usb/composite.h:632:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(&(d)->gadget->dev , fmt , ## args)
     ^~~~~~~
   drivers/usb/gadget/function/f_ccid.c:611:3: note: in expansion of macro 'DBG'
      DBG(ccidg->function.config->cdev,
      ^~~
   drivers/usb/gadget/function/f_ccid.c: In function 'ccidg_bulk_write':
   drivers/usb/gadget/function/f_ccid.c:683:5: warning: format '%i' expects argument of type 'int', but argument 4 has type 'size_t {aka long unsigned int}' [-Wformat=]
        "ccid: too much data. %i provided, but we can only handle %in",
        ^
   include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, 57-                                       ^~~
   include/linux/usb/composite.h:632:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(&(d)->gadget->dev , fmt , ## args)
     ^~~~~~~
   drivers/usb/gadget/function/f_ccid.c:682:3: note: in expansion of macro 'DBG'
      DBG(ccidg->function.config->cdev,
      ^~~
   drivers/usb/gadget/function/f_ccid.c:683:5: warning: format '%i' expects argument of type 'int', but argument 5 has type 'long unsigned int' [-Wformat=]
        "ccid: too much data. %i provided, but we can only handle %in",
        ^
   include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, 69-                                       ^~~
   include/linux/usb/composite.h:632:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(&(d)->gadget->dev , fmt , ## args)
     ^~~~~~~
   drivers/usb/gadget/function/f_ccid.c:682:3: note: in expansion of macro 'DBG'
      DBG(ccidg->function.config->cdev,
      ^~~

Please review and possibly fold the followup patch.

vim +423 drivers/usb/gadget/function/f_ccid.c

   403	
   404	static int ccidg_function_setup(struct usb_function *f,
   405			const struct usb_ctrlrequest *ctrl)
   406	{
   407		struct f_ccidg *ccidg = container_of(f, struct f_ccidg, function);
   408		struct usb_composite_dev *cdev	= f->config->cdev;
   409		struct usb_request *req		= cdev->req;
   410		int ret				= -EOPNOTSUPP;
   411		u16 w_index			= le16_to_cpu(ctrl->wIndex);
   412		u16 w_value			= le16_to_cpu(ctrl->wValue);
   413		u16 w_length			= le16_to_cpu(ctrl->wLength);
   414	
   415		if (!atomic_read(&ccidg->online))
   416			return -ENOTCONN;
   417	
   418		switch (ctrl->bRequestType & USB_TYPE_MASK) {
   419		case USB_TYPE_CLASS:
   420			{
   421			switch (ctrl->bRequest) {
   422			case CCIDGENERICREQ_GET_CLOCK_FREQUENCIES:
 > 423				*(u32 *) req->buf = cpu_to_le32(ccid_class_desc.dwDefaultClock);
 > 424				ret = min_t(u32, w_length,
   425						sizeof(ccid_class_desc.dwDefaultClock));
   426				break;
   427	
   428			case CCIDGENERICREQ_GET_DATA_RATES:
 > 429				*(u32 *) req->buf = cpu_to_le32(ccid_class_desc.dwDataRate);
 > 430				ret = min_t(u32, w_length, sizeof(ccid_class_desc.dwDataRate));
   431				break;
   432	
   433			default:
   434				VDBG(f->config->cdev,
   435					"ccid: invalid control req%02x.%02x v%04x i%04x l%d\n",
   436					ctrl->bRequestType, ctrl->bRequest,
   437					w_value, w_index, w_length);
   438			}
   439			}
   440		}
   441	
   442		/* responded with data transfer or status phase? */
   443		if (ret >= 0) {
   444			VDBG(f->config->cdev, "ccid: req%02x.%02x v%04x i%04x l%d\n",
   445				ctrl->bRequestType, ctrl->bRequest,
   446				w_value, w_index, w_length);
   447	
   448			req->length = ret;
   449			ret = usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);
   450			if (ret < 0)
   451				ERROR(f->config->cdev,
   452					"ccid: ep0 enqueue err %d\n", ret);
   453		}
   454	
   455		return ret;
   456	}
   457	
   458	static void ccidg_function_disable(struct usb_function *f)
   459	{
   460		struct f_ccidg *ccidg = func_to_ccidg(f);
   461		struct ccidg_bulk_dev *bulk_dev = &ccidg->bulk_dev;
   462		struct usb_request *req;
   463	
   464		/* Disable endpoints */
   465		usb_ep_disable(ccidg->in);
   466		usb_ep_disable(ccidg->out);
   467	
   468		/* Free endpoint related requests */
   469		if (!atomic_read(&bulk_dev->rx_req_busy))
   470			ccidg_request_free(bulk_dev->rx_req, ccidg->out);
   471		while ((req = ccidg_req_get(ccidg, &bulk_dev->tx_idle)))
   472			ccidg_request_free(req, ccidg->in);
   473	
   474		atomic_set(&ccidg->online, 0);
   475	
   476		/* Wake up threads */
   477		wake_up(&bulk_dev->write_wq);
   478		wake_up(&bulk_dev->read_wq);
   479	}
   480	
 > 481	int ccidg_start_ep(struct f_ccidg *ccidg, struct usb_function *f,
   482				struct usb_ep *ep)
   483	{
   484		struct usb_composite_dev *cdev = f->config->cdev;
   485		int ret;
   486	
   487		usb_ep_disable(ep);
   488	
   489		ret = config_ep_by_speed(cdev->gadget, f, ep);
   490		if (ret) {
   491			ERROR(cdev, "ccid: can't configure %s: %d\n", ep->name, ret);
   492			return ret;
   493		}
   494	
   495		ret = usb_ep_enable(ep);
   496		if (ret) {
   497			ERROR(cdev, "ccid: can't start %s: %d\n", ep->name, ret);
   498			return ret;
   499		}
   500	
   501		ep->driver_data = ccidg;
   502	
   503		return ret;
   504	}
   505	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

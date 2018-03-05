Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933211AbeCEHyd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 02:54:33 -0500
Received: from enterprise02.smtp.diehl.com ([193.201.238.220]:53206 "EHLO
        enterprise02.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751498AbeCEHya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 02:54:30 -0500
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.47,426,1515452400";
   d="scan'";a="29812873"
From: Denis OSTERLAND <denis.osterland@diehl.com>
To: "lkp@intel.com" <lkp@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgr@pengutronix.de" <mgr@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 2/4] rtc: isl1208: switch to rtc_register_device
Thread-Topic: [PATCH v2 2/4] rtc: isl1208: switch to rtc_register_device
Thread-Index: AQHTsJIOgn23vj3MIkaJa9AMwKaiz6O9vqeAgAN6/YA=
Date: Mon, 5 Mar 2018 07:44:21 +0000
Message-ID: <1520235861.5012.2.camel@diehl.com>
References: <1519821214-22379-3-git-send-email-Denis.Osterland@diehl.com>
         <201803031057.mSGucTXN%fengguang.wu@intel.com>
In-Reply-To: <201803031057.mSGucTXN%fengguang.wu@intel.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.153.3.249]
MIME-Version: 1.0
X-GBS-PROC: 415AWy8o668fDtCxszluzxx96n3SjvnVEtdxaXWlvV//0WrinnnpY5qmKSFSN+wT
X-MIMETrack: Itemize by SMTP Server on DIGNS28/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 05.03.2018 08:44:21,
        Serialize by ntm_grab.EXE on DIGNS28/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 05.03.2018 08:44:22,
        Serialize complete at 05.03.2018 08:44:22,
        Itemize by ntm_grab.EXE on DIGNS28/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 05.03.2018 08:44:22,
        Serialize by Router on DIGNS28/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 05.03.2018 08:44:22
X-TNEFEvaluated: 1
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-ID: <C8F36F68720D564DBDDA93D629CEDE6D@diehl.internal>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w257sdpq010598

Hi,

an obvious mistake by me.
isl1208 is introduced in patch 3/4.
I will send v3.
Sorry for that.

Regards Denis

Am Samstag, den 03.03.2018, 10:35 +0800 schrieb kbuild test robot:
> Hi Denis,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on abelloni/rtc-next]
> [also build test ERROR on v4.16-rc3 next-20180302]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Denis-OSTERLAND/rtc-isl1208-fixes-documentation-and-isl1219-support/20180303-093405
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
> config: x86_64-randconfig-x017-201808 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> Note: the linux-review/Denis-OSTERLAND/rtc-isl1208-fixes-documentation-and-isl1219-support/20180303-093405 HEAD 1d3cf882ecd061847968da1511ec956b9bf70d33 builds fine.
>       It only hurts bisectibility.
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from drivers/rtc/rtc-isl1208.c:16:0:
>    drivers/rtc/rtc-isl1208.c: In function 'isl1208_probe':
> > 
> > > 
> > > drivers/rtc/rtc-isl1208.c:677:29: error: 'isl1208' undeclared (first use in this function)
>      return rtc_register_device(isl1208->rtc);
>                                 ^
>    include/linux/rtc.h:261:37: note: in definition of macro 'rtc_register_device'
>      __rtc_register_device(THIS_MODULE, device)
>                                         ^~~~~~
>    drivers/rtc/rtc-isl1208.c:677:29: note: each undeclared identifier is reported only once for each function it appears in
>      return rtc_register_device(isl1208->rtc);
>                                 ^
>    include/linux/rtc.h:261:37: note: in definition of macro 'rtc_register_device'
>      __rtc_register_device(THIS_MODULE, device)
>                                         ^~~~~~
> > 
> > > 
> > > drivers/rtc/rtc-isl1208.c:678:1: warning: control reaches end of non-void function [-Wreturn-type]
>     }
>     ^
> 
> vim +/isl1208 +677 drivers/rtc/rtc-isl1208.c
> 
>    625	
>    626	static int
>    627	isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
>    628	{
>    629		int rc = 0;
>    630		struct rtc_device *rtc;
>    631	
>    632		if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>    633			return -ENODEV;
>    634	
>    635		if (isl1208_i2c_validate_client(client) < 0)
>    636			return -ENODEV;
>    637	
>    638		rtc = devm_rtc_allocate_device(&client->dev);
>    639		if (IS_ERR(rtc))
>    640			return PTR_ERR(rtc);
>    641	
>    642		rtc->ops = &isl1208_rtc_ops;
>    643	
>    644		i2c_set_clientdata(client, rtc);
>    645	
>    646		rc = isl1208_i2c_get_sr(client);
>    647		if (rc < 0) {
>    648			dev_err(&client->dev, "reading status failed\n");
>    649			return rc;
>    650		}
>    651	
>    652		if (rc & ISL1208_REG_SR_RTCF)
>    653			dev_warn(&client->dev, "rtc power failure detected, "
>    654				 "please set clock.\n");
>    655	
>    656		rc = sysfs_create_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
>    657		if (rc)
>    658			return rc;
>    659	
>    660		if (client->irq > 0) {
>    661			rc = devm_request_threaded_irq(&client->dev, client->irq, NULL,
>    662						       isl1208_rtc_interrupt,
>    663						       IRQF_SHARED | IRQF_ONESHOT,
>    664						       isl1208_driver.driver.name,
>    665						       client);
>    666			if (!rc) {
>    667				device_init_wakeup(&client->dev, 1);
>    668				enable_irq_wake(client->irq);
>    669			} else {
>    670				dev_err(&client->dev,
>    671					"Unable to request irq %d, no alarm support\n",
>    672					client->irq);
>    673				client->irq = 0;
>    674			}
>    675		}
>    676	
>  > 677		return rtc_register_device(isl1208->rtc);
>  > 678	}
>    679	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
Diehl AKO Stiftung & Co. KG, Pfannerstraße 75-83, 88239 Wangen im Allgäu
Bereichsvorstand: Dr.-Ing. Michael Siedentop (Sprecher), Josef Fellner (Mitglied)
Sitz der Gesellschaft: Wangen i.A. – Registergericht: Amtsgericht Ulm HRA 620609 – Persönlich haftende Gesellschafterin: Diehl Verwaltungs-Stiftung – Sitz: Nürnberg – Registergericht: Amtsgericht Nürnberg HRA 11756 –
Vorstand: Dr.-Ing. E.h. Thomas Diehl (†) (Vorsitzender), Herr Dipl.-Wirtsch.-Ing. Wolfgang Weggen (stellvertretender Vorsitzender), Dipl.-Kfm. Claus Günther, Dipl.-Kfm. Frank Gutzeit, Dr.-Ing. Heinrich Schunk, Dr.-Ing. Michael Siedentop , Dipl.-Kfm. Dr.-Ing. Martin Sommer, Dipl.-Ing. (FH) Rainer von Borstel, Vorsitzender des Aufsichtsrates: Dr. Klaus Maier
___________________________________________________________________________________________________
Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht. Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited.

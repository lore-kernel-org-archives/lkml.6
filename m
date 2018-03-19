Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932578AbeCSJJh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:09:37 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:41549 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754531AbeCSJJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:09:28 -0400
From: "Ng, Angela" <sock-chan.ng@hpe.com>
To: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Upstream of minor i2c enhancement of i2c kernel driver code
Thread-Topic: Upstream of minor i2c enhancement of i2c kernel driver code
Thread-Index: AdO8vRPo7S/EzbLcQoGTUqEsbPaDlACZ2ZnQAAfHpFAAB5BUsA==
Date: Mon, 19 Mar 2018 09:09:18 +0000
Message-ID: <TU4PR8401MB0909EF5EBF389C17E775E834D2D40@TU4PR8401MB0909.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sock-chan.ng@hpe.com;
x-originating-ip: [16.242.247.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TU4PR8401MB0334;7:JlexyqDZs5LkgR9ZDGZ6l9Mme0QBrvH7WJlPjhN75SeTLR8g5DClXZYBG9xU751VNVsZb0DIvvvZRKAWekSPg4tDWgHvIeihxSoxSPWbbJgMvqA0YXt5GR5Fz7vEg31zQ7Sk+9J4WGl7lJQqbTk22ImyfiLmyFaYcGFEIDkNKVmK5tYaFs7RYJk7UQicHJLFPVBr4k0/4kB16c6Z5mHX+NqzYmIDQpyP1zJXy67/RFsR+i91ooAxJX74aPvRMOwe
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ecf614c2-15ef-4652-799b-08d58d791870
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:TU4PR8401MB0334;
x-ms-traffictypediagnostic: TU4PR8401MB0334:
x-microsoft-antispam-prvs: <TU4PR8401MB03340E9C71A4B9BB0256A3FFD2D40@TU4PR8401MB0334.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:TU4PR8401MB0334;BCL:0;PCL:0;RULEID:;SRVR:TU4PR8401MB0334;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(396003)(346002)(39860400002)(366004)(189003)(199004)(13464003)(2201001)(97736004)(59450400001)(186003)(55016002)(6436002)(9686003)(53936002)(66066001)(68736007)(8936002)(6246003)(7696005)(86362001)(2900100001)(102836004)(8676002)(316002)(81156014)(81166006)(26005)(229853002)(6506007)(53546011)(5250100002)(2501003)(106356001)(25786009)(99286004)(478600001)(7736002)(110136005)(14454004)(6116002)(551934003)(3846002)(33656002)(305945005)(105586002)(3280700002)(5660300001)(2906002)(74316002)(3660700001);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0334;H:TU4PR8401MB0909.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: UI1tAyVOL5ruGouJvOnWO2+/amtzQehWsnVYHW0ahVwuhk0cFOedB+BlTh1IClVloyj0X08kG2/bnPt7CPtk+4B+t2cE7rWtQRujheUlkEGTbkkkyDRQJj372znYsStzVcD7la2r/UhHwgS12FD43+3fF3VksdxsG6QLjGkcHymW7z6+yys6a3Zjtgavxfst7I1vTKEUqCHuc3kWb64JcKPofVdDITZaKLXt2flH3g4Hbgr926spBTvy+4peqQ7klUVwJ6c6uwH0yVrbZf2TLfdbndcxtk6mdGn4zyGA8jk7oC1HTLjvSYm2nzL0eEkL6sUYNhVJgOjEcd3eKllShg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf614c2-15ef-4652-799b-08d58d791870
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 09:09:18.2126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0334
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2J99iPk009361

Adding   linux-kernel@vger.kernel.org and wsa@the-dreams.de  for the recipients of the patches. 

Thanks & Best Regards,
Ng Sock Chan (Angela)
Œ‚Ê≠’È
Software Engineer (HPN) 


-----Original Message-----
From: Ng, Angela 
Sent: Monday, March 19, 2018 1:32 PM
To: 'linux-i2c@vger.kernel.org' <linux-i2c@vger.kernel.org>
Subject: RE: Upstream of minor i2c enhancement of i2c kernel driver code



Hello Linux-i2c community, 

We would like to upstream a minor enhancement for i2c-i801.c.
This patch adds  I2C_FUNC_SMBUS_PROC_CALL functionality to i2c-i801.c. 


diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c ===================================================================
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -783,6 +783,14 @@
 			outb_p(command, SMBHSTCMD(priv));
 		block = 1;
 		break;
+	case I2C_SMBUS_PROC_CALL:
+		outb_p(((addr & 0x7f) << 1)| (I2C_SMBUS_WRITE & 0x01),
+			SMBHSTADD(priv));
+		outb_p(command, SMBHSTCMD(priv));
+		outb_p(data->word & 0xff, SMBHSTDAT0(priv));
+		outb_p((data->word & 0xff00) >> 8, SMBHSTDAT1(priv));
+		xact = I801_PROC_CALL;
+		break;
 	default:
 		dev_err(&priv->pci_dev->dev, "Unsupported transaction %d\n",
 			size);
@@ -799,9 +807,21 @@
 	if (block)
 		ret = i801_block_transaction(priv, data, read_write, size,
 					     hwpec);
-	else
+	else {
+		unsigned char hostc = 0;
+
+		if (xact == I801_PROC_CALL) {
+			/* clear I2C_EN bit in configuration register for proc calls */
+			pci_read_config_byte(priv->pci_dev, SMBHSTCFG, &hostc);
+			pci_write_config_byte(priv->pci_dev, SMBHSTCFG,
+				(hostc & (~SMBHSTCFG_I2C_EN)));
+		}
 		ret = i801_transaction(priv, xact);
-
+		if (xact == I801_PROC_CALL) {
+			/* restore saved configuration register value */
+			pci_write_config_byte(priv->pci_dev, SMBHSTCFG, hostc);
+		}
+	}
 	/* Some BIOSes don't like it when PEC is enabled at reboot or resume
 	   time, so we forcibly disable it after every transaction. Turn off
 	   E32B for the same reason. */
@@ -813,7 +833,14 @@
 		goto out;
 	if (ret)
 		goto out;
-	if ((read_write == I2C_SMBUS_WRITE) || (xact == I801_QUICK))
+
+	/* i2c-dev.h has defined i2c_smbus_proc_call to pass I2C_SMBUS_WRITE
+	   to the nderlying driver. However, process call is only defined for
+	   read transactions. Process call writes will be using
+	   i2c_smbus_write_i2c_block_data driver api.
+	*/
+	if (((read_write == I2C_SMBUS_WRITE) || (xact == I801_QUICK)) &&
+		(xact != I801_PROC_CALL))
 		goto out;
 
 	switch (xact & 0x7f) {
@@ -821,6 +848,7 @@
 	case I801_BYTE_DATA:
 		data->byte = inb_p(SMBHSTDAT0(priv));
 		break;
+	case I801_PROC_CALL:
 	case I801_WORD_DATA:
 		data->word = inb_p(SMBHSTDAT0(priv)) +
 			     (inb_p(SMBHSTDAT1(priv)) << 8); @@ -840,6 +868,7 @@
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
 	       I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK |
+	       I2C_FUNC_SMBUS_PROC_CALL |
 	       ((priv->features & FEATURE_SMBUS_PEC) ? I2C_FUNC_SMBUS_PEC : 0) |
 	       ((priv->features & FEATURE_I2C_BLOCK_READ) ?
 		I2C_FUNC_SMBUS_READ_I2C_BLOCK : 0);

 


Thanks & Best Regards,
Ng Sock Chan (Angela)
Œ‚Ê≠’È
Software Engineer (HPN) 

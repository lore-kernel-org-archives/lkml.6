Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbeBTToB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:44:01 -0500
Received: from mail-by2nam03on0060.outbound.protection.outlook.com ([104.47.42.60]:1231
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751053AbeBTTn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:43:58 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
Subject: Re: [PATCH v4] rtc: isl12026: Add driver.
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        David Daney <david.daney@cavium.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20180216194415.6103-1-david.daney@cavium.com>
 <20180220110344.GE18058@piout.net>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <4dfd0a27-7c03-13a0-acdb-890817e47bfc@caviumnetworks.com>
Date: Tue, 20 Feb 2018 11:43:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180220110344.GE18058@piout.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN4PR0701CA0004.namprd07.prod.outlook.com
 (2603:10b6:803:28::14) To MWHPR07MB3181.namprd07.prod.outlook.com
 (2603:10b6:300:e1::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efb753a4-94bc-4c2b-4ca4-08d5789a4712
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR07MB3181;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3181;3:eL7FnYu5MPddBgSJ9DhX7DAMlSavgN1RzHL5CgMHWQ7RIKVLurVqfAoFoZ4eKmWb2fQlAJMRZKxEoKFp8s/gmqxtvpfarjB2PcozQxXWxqx9VapAYRIDcJ/db1wOh7XPDDvCovbmX0bre6edQXYGMwoDUPT3MEJpmR+glAJaDUOFmxPL9+aJzRhI114n7O+a7lbPDj1uTHd+S0Kh9m8rmqpqxxA7+iIAaswcOHDinJPLJXxAkaq8OMMeSBIs9+Pb;25:YVKnHmwgiFsya/xR/pIZeLA8bGId738HqtyK/yc3ncMv2itnu/EEvqNFenad+W/c4AdUDTTSKotatT5MinjmRfZoHzg1kiC22Nu1+shFK7eurhZyeof8QMMCTRSPbyzBuqtcS3OG1CEErebYUcze2PXomQ4jh2n1pMI0ILu5mWG5UARWo2lp6/OMiyUGrEHTldLPcZ0c6dI0WRvN6sooHheL/n7uMr2kuxrSM0sXMbc0rg8mNRpDKDF/XxFkY10+OoMdzWnqLI8/CVeI+3DVyeTg2E0RhujsLKC/Zjc4ncZt8F0sGv6VKpUDfxygHn4Zo/IWS2Gu/Y2gMh7hHQRYqQ==;31:TRliovJC4YVABbnLcgv3YKxlYLASzjwFoozn3eMG7r+jzN60pNlfnICRyyqHMvBZRb20/Rb54wK2BNgsvoWl2c9b1f3ry1SMQT7zeY6iDUgVqBW/lx2fVy9NHTDUh7YjEpdbUKs68dfiBNGhOMOK4KmEl6ytmokQdXcq3alhchZtOqvMHrTjT4Sov9vJ2kw1/2Ovbnot3WXUiqGWDPj40hVTMLu4TaPSdUdQxlByJTU=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3181:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3181;20:jWlm925sGDRujuxbZro1iiViN4Xb8AqSIGfuwaL2UHyCYrtookBAjaq//erakds+pdVxwRwtS/UqjkjhG23cr7/cghKLs4eXkRfsMv+LRi/Me8iAzTbxll20bxMPcTFnZySwZHCN18Zs949Y2uQh+P75+09JmfoG1lAucupAXYruP2Fdu9inmC3w63sYlE+Yg1AEsm2PzBVPMM52jalvYIs565kLvJ4q5szEBW5sCCgFetJmYBtMeoHbssk+8FK6low0WPfVaak+RcDBEQc5IsCGJ2ngvaRfnczvv8ITw38f7uefgR1NcCONNeNxhfMRbUSZvJGWp9XExYVn/SMNrD4XlEnH+ym854cW1FbInt7Mm8NFKdF6ohysFsXYaXZRr0fNFJnMX1r+TRtf6Wf4Y2Pr60p7UX2zmWcXO8rCHcfK9B4tAj+joPAY3bub4jQDi3k4S/4Ww9r1JxJz/N73wSrwnSRfnZSJRvvg5YIo/lDeZfNVtb68Tl0XI7eL+pbCsnBJydKa0bA1seDeNDS3TO7+h5D43k0MRAyFe1ylEZIDcAVa/cNzeAZ8fJpDS1e7caLlFGZYQVzYn+jlnFUfosy21h1pkHdmnqvAFltYu4w=;4:L3dNQC7NKB87OYIsMPH8bgVbUI2EGdOJVELQ+/k+YKAJDySy+ifvexXqtYMzpNnpo6qQdhKxKZW208XNAlWMD83hDPUiw409xpmU3YroLJmYsLYy1whRrRlSIFVTX+Kqz6mjV1Rh+U7mr6EtbVUcXb8AZpB5xyiMH5hG3P6ymunLlxRaHMAhsICpbrKiJKn3YMO3m6nOSeMc3kX2GAb3h2GZgf4UFoqsc5w92GpeX9vCrPFAJT1/hj2c8ivgvZhT0ejHgrEPl3QknA/ZGsGG6Q==
X-Microsoft-Antispam-PRVS: <MWHPR07MB31810040F388DCB28BDA3BEE97CF0@MWHPR07MB3181.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001059)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(10201501046)(3231101)(944501161)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR07MB3181;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3181;
X-Forefront-PRVS: 05891FB07F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(39380400002)(346002)(376002)(396003)(189003)(199004)(230700001)(229853002)(3846002)(6116002)(6486002)(97736004)(36756003)(2906002)(5660300001)(6246003)(69596002)(53936002)(76176011)(106356001)(6512007)(50466002)(2486003)(478600001)(23676004)(105586002)(52146003)(52116002)(31696002)(4326008)(65826007)(64126003)(67846002)(72206003)(53546011)(31686004)(8936002)(68736007)(26005)(6506007)(54906003)(65806001)(386003)(65956001)(16526019)(58126008)(186003)(66066001)(39060400002)(305945005)(81156014)(316002)(53416004)(25786009)(42882006)(8676002)(2950100002)(47776003)(6666003)(81166006)(59450400001)(110136005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3181;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzMTgxOzIzOm9UUDZBc2VQbFFQaEQraG0vQ3lzZ0JIVDl0?=
 =?utf-8?B?Y2RhcWlSNHhvdFRNK1BoVHpPNCt5RS9DMENYOW12UG9jRkF1VG1VRWQwYjdC?=
 =?utf-8?B?S2xJVVpxOVBWYngwQnd3L1NDQkM4blorSHdMTFN0WnltVDJCZnMzaS9WdGI4?=
 =?utf-8?B?NVN6ME1iZDZYazNIMmNLdEZxUHIyMFlpRmVweVpxcWMyOFJuV0lkcFZhS3k3?=
 =?utf-8?B?Z0ljTDVxU1F4dldaRlpJTjhkN2dQalYrUTZWem5tTXcreHlpdFdtVjlXRzZW?=
 =?utf-8?B?M29JaDlBWUNqNjVaSjB3OVZDQXFaY3lsYWdFcjB0bThMM0k2TjBOa1hnUG5o?=
 =?utf-8?B?Yit4cTVtTTFDcUFpVzN4TndhYjJVc3E1TDRkOW1QYW8vOHozYVExQXRVdytF?=
 =?utf-8?B?V21pQmxGL3l2QUpPTjhRMVp5N0JYUGNqdkVwSlpKL3JWUmNHSlptVUE1aS96?=
 =?utf-8?B?S3lMSHQzVGprL0J5VFE0UGVCUnZSbjZZN0MydWlYRUVVeW1NRzdZc0pSSXRa?=
 =?utf-8?B?YXBTZ0F4T241djFTT28xSUZpVnFFYk93emkreDVDbS9SRDVMc3RpNmNWejN4?=
 =?utf-8?B?d2J2WlR0anp6eGNVTGZQZGtXT0RNZEVTL0ZaK1hCY2NLL1VwaWtJaXZvS1VT?=
 =?utf-8?B?L0s3OXV3emt5b1VxWXdvaXkvaW5ZRU5PTGtFVGh1VG42RmJRQUdsUUxub20r?=
 =?utf-8?B?aE04QTRNSmdnYzh4M0dhR1pFSnBhWlQvSWdseVNvdDk0cC9xd01lSEZwTEdR?=
 =?utf-8?B?WlRRNjhjZXVZdG9tclEvK1JTNW1BQ3JqZ1JuQ3FSanNyUEFHMThYTUF5Mk0r?=
 =?utf-8?B?bnJaeTZMT2dYT1VITDBCaytHUUg3UHlBeCtIR1lVOG85Z3FMYjJPMkhVWk1v?=
 =?utf-8?B?bDRkbzk2eTdmSXo3Z3JUTk1sb0FZNXhxS1cxNDVGZ1gzdGg1UXRrME9TUGZ6?=
 =?utf-8?B?WFlLOFVDa1JBMVRldWhBY3NvejA3TjRzc3R6S1VaMm1UeGFPclpGZ2tYSnY3?=
 =?utf-8?B?NWJjRC93MEczM0ZFdlYranRUS2lCY1hlSDQrUjE0VjVjaFhVdUFqVlFYcitE?=
 =?utf-8?B?d0d6MnU2MzNJOWt2b3pxSTVGR0pSQ1FpZEM2T0FCdjJOVVo1ODRUUmlWek9M?=
 =?utf-8?B?WG83VTZpQVdBYU52VzVGVG5NVTk2RFlqVFlGMW83d1R1dTIyQm44VStqYWpG?=
 =?utf-8?B?WnBYVXczelZndnZXbXdCUjRRTHo4QTJUbkltVEI0UHJVQmpyY0RhZWJLQ3li?=
 =?utf-8?B?NlM1aGFUNU9aZVhsYnhINURVNGlUTk52UkFsbFdCNXEzR2Q0U2c2aUY2MWlJ?=
 =?utf-8?B?T3N5WE81ZWkrQTdtWHN4eTdLSk1XYTVLVnZsZDIvZWEyT3dySy9KNnBiLzlq?=
 =?utf-8?B?YnVpMnk3a1lFQ0R0Z1lTR2ttQzFYMWpCQ09yYTV3d1BRMmI3alVXQzhSTGNi?=
 =?utf-8?B?QVM1TW5EVnZ6b1ZnWjdhcHMyejZlZjk5RklsN2JNaHNhM0QxdWhCSlFmRzdG?=
 =?utf-8?B?bVNzVGlVdVdDQWxwQmduVEs0NzlZNC84YlJUaVl1Ykl6YmM1TGFRODJzWTZ1?=
 =?utf-8?B?djBTQXRSSFdFRXh4dHBSak1xQ0E2cW0yV2QvbGxMTkdWQ3RwZG41U2lESWNI?=
 =?utf-8?B?Z3Y3M2lSR3RMaGYyL0xaQ0VyUi9xRG5oVjhmRCtRcDFrQTROL0pQUy9MSXEr?=
 =?utf-8?B?MmNOU1J2Z2orMWNybTdJSXZXay84YUJlSlprMzF4WjVFcVNib291UUt5UFFu?=
 =?utf-8?B?UmRnZWh5ZmcrZk5KajBvSkwxNEFhVzZ2WDNIZDlPVEdNM2NWU1dqc1JzOEF4?=
 =?utf-8?B?dzQ5Y1ZYcEQzeDVTb1IwWDY4UmFTMm5VSGNtbTJUWXRCSHl4THgvYW4veWhZ?=
 =?utf-8?B?d1ZSRGtHbWJEY3hSM3BXNmwvR1FmeG5KL2I1RFpiZDRsMUF3MnUrazVKMFI4?=
 =?utf-8?B?UlA3bXhDWWdkUUZHMXcreGY0K0J1K3p4UjR0dm9hVGV0bXdYdTVWS2w0M3VM?=
 =?utf-8?B?TXN1ZE84alFNV2NjekpWVTBaU09Pc2ZHWmY2Zz09?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3181;6:aFl4qxVK1eUb2kFxrzjDOAxS0gJJQce7CSOhOfCUOgJ1J+SVhHYYrfdyOrfzF+8B5c6RmEEEqb405LZ7T0KyK/mCAjoweP1KToAX0Jikp7Ocp9xzqG6r5SbwO1U9CKjOqZS+w070sM4AcoD23WVkE4/M+M3z/kCQZQEnue6LC/K+BXRt3ZxKVlMd3nIbZaTfscLSWIOYkVzXZ1xA2YJWIH2OklX5UICPVnMZZN3oCODcXkJKslnrhD6aiuHS32zfMbMqt+nNVEUmluLSrJf37PAoVr/FBQzUM3kE91cVph35sstYQMGiHRQl7hrBz8NZU3jtwZotVx67sJjBuyBjCWoPEYOO125X54FELgTAXJw=;5:t9yHGySCyDBeHC3kXgof3FuKBh20KXi8QOrzz4zbBjbr7EJkukFbMOZxlsahvQ/VGXDUK8mla4tM9J3WtMXORRlNKicn6E8e8f+DfhH4h4mq/RK4KRdtB/frMcCKuRY0yuqWKuGAG3kScuwatqQMa4MqWijI6aL+2KhLJoBbM+s=;24:1x5a/arLWs7PVqcUNqcd9nkt4N9+QZkCegstgLzZFiC16vU3uPAalSV62D0Fom/ltv8VaRKr4Gj5/DxWijCRXI12YfArmV+Iuct7nlbJAvU=;7:A5rl8YGb1BNIyNz03sGbd//SMjPJhvciXsE7Fi9bCXd1ou9Oo68ptUDsuHt/MxZHuf/i0sGfoIpd0w10NLA44tHWZT+rrsdFffpoQMggLnLvzLiRf5T+v5qHPiMft17tDgJfVW/PLYpQr0PQq9L5PJOCDa7OJ2zeTK5BYSp5aLxF0lJm0dZhB5Rt/iXlJP8JTrEcJQutC/qsCDpN2NmQPKRSm8LJwhLpvfJxswCRvVrBIVmS8OmbdStu+5azk0U0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 19:43:54.5783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efb753a4-94bc-4c2b-4ca4-08d5789a4712
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3181
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/2018 03:03 AM, Alexandre Belloni wrote:
[...]


>> diff --git a/drivers/rtc/rtc-isl12026.c b/drivers/rtc/rtc-isl12026.c
>> new file mode 100644
>> index 000000000000..29e5bdf96c67
>> --- /dev/null
>> +++ b/drivers/rtc/rtc-isl12026.c
>> @@ -0,0 +1,529 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * An I2C driver for the Intersil ISL 12026
>> + *
>> + * Copyright (c) 2018 Cavium, Inc.
>> + */
>> +#include <linux/bcd.h>
>> +#include <linux/delay.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/nvmem-provider.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/rtc.h>
>> +#include <linux/slab.h>
>> +
>> +/* register offsets */
>> +#define ISL12026_REG_PWR	0x14
>> +# define ISL12026_REG_PWR_BSW	BIT(6)
>> +# define ISL12026_REG_PWR_SBIB	BIT(7)
>> +#define ISL12026_REG_SC		0x30
>> +#define ISL12026_REG_HR		0x32
>> +# define ISL12026_REG_HR_MIL	BIT(7)	/* military or 24 hour time */
>> +#define ISL12026_REG_SR		0x3f
>> +# define ISL12026_REG_SR_RTCF	BIT(0)
>> +# define ISL12026_REG_SR_WEL	BIT(1)
>> +# define ISL12026_REG_SR_RWEL	BIT(2)
>> +# define ISL12026_REG_SR_MBZ	BIT(3)
>> +# define ISL12026_REG_SR_OSCF	BIT(4)
>> +
>> +/* The EEPROM array responds at i2c address 0x57 */
>> +#define ISL12026_EEPROM_ADDR	0x57
>> +
>> +#define ISL12026_PAGESIZE 16
>> +#define ISL12026_NVMEM_WRITE_TIME 20
>> +
>> +struct isl12026 {
>> +	struct rtc_device *rtc;
>> +	struct i2c_client *nvm_client;
>> +	struct nvmem_config nvm_cfg;
>> +	/*
>> +	 * RTC write operations require that multiple messages be
>> +	 * transmitted, we hold the lock for all accesses to the
>> +	 * device so that these sequences cannot be disrupted.  Also,
>> +	 * the write cycle to the nvmem takes many ms during which the
>> +	 * device does not respond to commands, so holding the lock
>> +	 * also prevents access during these times.
>> +	 */
>> +	struct mutex lock;
>> +};
>> +
>> +static int isl12026_read_reg(struct i2c_client *client, int reg)
>> +{
>> +	struct isl12026 *priv = i2c_get_clientdata(client);
>> +	u8 addr[] = {0, reg};
>> +	u8 val;
>> +	int ret;
>> +
>> +	struct i2c_msg msgs[] = {
>> +		{
>> +			.addr	= client->addr,
>> +			.flags	= 0,
>> +			.len	= sizeof(addr),
>> +			.buf	= addr
>> +		}, {
>> +			.addr	= client->addr,
>> +			.flags	= I2C_M_RD,
>> +			.len	= 1,
>> +			.buf	= &val
>> +		}
>> +	};
> 
> I'm pretty sure you can use regmap instead of open coding all the i2c
> transfers, did you try?

I couldn't figure out how to make it do the device-atomic stores to 
SR.RWEL and SR.WEL that must precede certain register store operations. 
Also, dealing with locking across multiple i2c target addresses seems 
problematical with the regmap helpers.

The open coding doesn't clutter things up too much, and allows us to 
follow the isl12026 protocol without having to jump through too many hoops.

> 
>> +
>> +	mutex_lock(&priv->lock);
>> +
> 
> Also, regmap will remove the need for that lock.

Since


> 
>> +	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
>> +	if (ret != ARRAY_SIZE(msgs)) {
>> +		dev_err(&client->dev, "read reg error, ret=%d\n", ret);
>> +		ret = ret < 0 ? ret : -EIO;
>> +	} else {
>> +		ret = val;
>> +	}
>> +
>> +	mutex_unlock(&priv->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int isl12026_write_reg(struct i2c_client *client, int reg, u8 val)
>> +{
>> +	struct isl12026 *priv = i2c_get_clientdata(client);
>> +	int ret;
>> +	u8 op[3];
>> +	struct i2c_msg msg = {
>> +		.addr	= client->addr,
>> +		.flags	= 0,
>> +		.len	= 1,
>> +		.buf	= op
>> +	};
>> +
>> +	mutex_lock(&priv->lock);
>> +
>> +	/* Set SR.WEL */
>> +	op[0] = 0;
>> +	op[1] = ISL12026_REG_SR;
>> +	op[2] = ISL12026_REG_SR_WEL;
>> +	msg.len = 3;
>> +	ret = i2c_transfer(client->adapter, &msg, 1);
>> +	if (ret != 1) {
>> +		dev_err(&client->dev, "write error SR.WEL, ret=%d\n", ret);
>> +		ret = ret < 0 ? ret : -EIO;
>> +		goto out;
>> +	}
> 
> If you don't clear SR.WEL, I don't think you need to set it each time
> you write to the RTC. I would just set SR.WEL at probe time and let it
> there. That removes two i2c writes for each write operation.

I don't like the idea of leaving the thing partially armed when write 
operations should be rare.


[...]
>> +static int isl12026_rtc_read_time(struct device *dev, struct rtc_time *tm)
>> +{
>> +	struct i2c_client *client = to_i2c_client(dev);
>> +	struct isl12026 *priv = i2c_get_clientdata(client);
>> +	u8 ccr[8];
>> +	u8 addr[2];
>> +	u8 sr;
>> +	int ret;
>> +	struct i2c_msg msgs[] = {
>> +		{
>> +			.addr	= client->addr,
>> +			.flags	= 0,
>> +			.len	= sizeof(addr),
>> +			.buf	= addr
>> +		}, {
>> +			.addr	= client->addr,
>> +			.flags	= I2C_M_RD,
>> +		}
>> +	};
>> +
>> +	mutex_lock(&priv->lock);
>> +
>> +	/* First, read SR */
>> +	addr[0] = 0;
>> +	addr[1] = ISL12026_REG_SR;
>> +	msgs[1].len = 1;
>> +	msgs[1].buf = &sr;
>> +
>> +	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
>> +	if (ret != ARRAY_SIZE(msgs)) {
>> +		dev_err(&client->dev, "read error, ret=%d\n", ret);
>> +		ret = ret < 0 ? ret : -EIO;
>> +		goto out;
>> +	}
>> +
>> +	if (sr & ISL12026_REG_SR_RTCF)
>> +		dev_warn(&client->dev, "Real-Time Clock Failure on read\n");
>> +	if (sr & ISL12026_REG_SR_OSCF)
>> +		dev_warn(&client->dev, "Oscillator Failure on read\n");
>> +
>> +	/* Second, CCR regs */
>> +	addr[0] = 0;
>> +	addr[1] = ISL12026_REG_SC;
>> +	msgs[1].len = sizeof(ccr);
>> +	msgs[1].buf = ccr;
>> +
>> +	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
>> +	if (ret != ARRAY_SIZE(msgs)) {
>> +		dev_err(&client->dev, "read error, ret=%d\n", ret);
>> +		ret = ret < 0 ? ret : -EIO;
>> +		goto out;
>> +	}
>> +
>> +	tm->tm_sec = bcd2bin(ccr[0] & 0x7F);
>> +	tm->tm_min = bcd2bin(ccr[1] & 0x7F);
>> +	if (ccr[2] & ISL12026_REG_HR_MIL)
>> +		tm->tm_hour = bcd2bin(ccr[2] & 0x3F);
>> +	else
>> +		tm->tm_hour = bcd2bin(ccr[2] & 0x1F) +
>> +			((ccr[2] & 0x20) ? 12 : 0);
>> +	tm->tm_mday = bcd2bin(ccr[3] & 0x3F);
>> +	tm->tm_mon = bcd2bin(ccr[4] & 0x1F) - 1;
>> +	tm->tm_year = bcd2bin(ccr[5]);
>> +	if (bcd2bin(ccr[7]) == 20)
>> +		tm->tm_year += 100;
>> +	tm->tm_wday = ccr[6] & 0x07;
>> +
>> +	ret = rtc_valid_tm(tm);
> 
> This rtc_valid_tm is unnecessary, you can simply return 0.

It may be possible for invalid values to be programmed into the RTC, 
this would catch that case.


> 
>> +out:
>> +	mutex_unlock(&priv->lock);
>> +	return ret;
>> +}
>> +
>> +static const struct rtc_class_ops isl12026_rtc_ops = {
>> +	.read_time	= isl12026_rtc_read_time,
>> +	.set_time	= isl12026_rtc_set_time,
>> +};
>> +
>> +static int isl12026_nvm_read(void *p, unsigned int offset,
>> +			     void *val, size_t bytes)
>> +{
>> +	struct isl12026 *priv = p;
>> +	int ret;
>> +	u8 addr[2];
>> +	struct i2c_msg msgs[] = {
>> +		{
>> +			.addr	= priv->nvm_client->addr,
>> +			.flags	= 0,
>> +			.len	= sizeof(addr),
>> +			.buf	= addr
>> +		}, {
>> +			.addr	= priv->nvm_client->addr,
>> +			.flags	= I2C_M_RD,
>> +			.buf	= val
>> +		}
>> +	};
>> +
>> +	if (offset >= priv->nvm_cfg.size)
>> +		return 0; /* End-of-file */
>> +	if (offset + bytes > priv->nvm_cfg.size)
>> +		bytes = priv->nvm_cfg.size - offset;
>> +
>> +	mutex_lock(&priv->lock);
> 
> You can completely remove the need for that lock by taking
> priv->rtc->ops_lock here.

Good point.  I will try doing that.


> 
>> +
>> +	/* 2 bytes of address, most significant first */
>> +	addr[0] = offset >> 8;
>> +	addr[1] = offset;
>> +	msgs[1].len = bytes;
>> +	ret = i2c_transfer(priv->nvm_client->adapter, msgs, ARRAY_SIZE(msgs));
>> +
>> +	mutex_unlock(&priv->lock);
>> +
>> +	if (ret != ARRAY_SIZE(msgs)) {
>> +		dev_err(priv->nvm_cfg.dev, "nvmem read error, ret=%d\n", ret);
>> +		return ret < 0 ? ret : -EIO;
>> +	}
>> +
>> +	return bytes;
>> +}
>> +
>> +static int isl12026_nvm_write(void *p, unsigned int offset,
>> +			      void *val, size_t bytes)
>> +{
>> +	struct isl12026 *priv = p;
>> +	int ret = -EIO;
>> +	u8 *v = val;
>> +	size_t chunk_size, num_written;
>> +	u8 payload[ISL12026_PAGESIZE + 2]; /* page + 2 address bytes */
>> +	struct i2c_msg msgs[] = {
>> +		{
>> +			.addr	= priv->nvm_client->addr,
>> +			.flags	= 0,
>> +			.buf	= payload
>> +		}
>> +	};
>> +
>> +	if (offset >= priv->nvm_cfg.size)
>> +		return 0; /* End-of-file */
>> +	if (offset + bytes > priv->nvm_cfg.size)
>> +		bytes = priv->nvm_cfg.size - offset;
>> +
>> +	mutex_lock(&priv->lock);
>> +
>> +	num_written = 0;
>> +	while (bytes) {
>> +		chunk_size = round_down(offset, ISL12026_PAGESIZE) +
>> +			ISL12026_PAGESIZE - offset;
>> +		chunk_size = min(bytes, chunk_size);
>> +		/*
>> +		 * 2 bytes of address, most significant first, followed
>> +		 * by page data bytes
>> +		 */
>> +		memcpy(payload + 2, v + num_written, chunk_size);
>> +		payload[0] = offset >> 8;
>> +		payload[1] = offset;
>> +		msgs[0].len = chunk_size + 2;
>> +		ret = i2c_transfer(priv->nvm_client->adapter,
>> +				   msgs, ARRAY_SIZE(msgs));
>> +		if (ret != ARRAY_SIZE(msgs)) {
>> +			dev_err(priv->nvm_cfg.dev,
>> +				"nvmem write error, ret=%d\n", ret);
>> +			ret = ret < 0 ? ret : -EIO;
>> +			break;
>> +		}
>> +		bytes -= chunk_size;
>> +		offset += chunk_size;
>> +		num_written += chunk_size;
>> +		msleep(ISL12026_NVMEM_WRITE_TIME);
>> +	}
>> +
>> +	mutex_unlock(&priv->lock);
>> +
>> +	return num_written >= 0 ? num_written : ret;
> 
> nvmem requires that you return 0 or an error, not the number of bytes
> written. Also, in that case num_written >= 0 will always be true (size_t
> is unsigned).


Yes, the 0-day bot found these problems too.

I will fix this.


> 
>> +}
>> +
>> +static void isl12026_force_power_modes(struct i2c_client *client)
>> +{
>> +	int ret;
>> +	int pwr, requested_pwr;
>> +	u32 bsw_val, sbib_val;
>> +	bool set_bsw, set_sbib;
>> +
>> +	/*
>> +	 * If we can read the of_property, set the specified value.
>> +	 * If there is an error reading the of_property (likely
>> +	 * because it does not exist), keep the current value.
>> +	 */
>> +	ret = of_property_read_u32(client->dev.of_node,
>> +				   "isil,pwr-bsw", &bsw_val);
>> +	set_bsw = (ret == 0);
>> +
>> +	ret = of_property_read_u32(client->dev.of_node,
>> +				   "isil,pwr-sbib", &sbib_val);
>> +	set_sbib = (ret == 0);
>> +
>> +	/* Check if PWR.BSW and/or PWR.SBIB need specified values */
>> +	if (!set_bsw && !set_sbib)
>> +		return;
>> +
>> +	pwr = isl12026_read_reg(client, ISL12026_REG_PWR);
>> +	if (pwr < 0) {
>> +		dev_warn(&client->dev, "Error: Failed to read PWR %d\n", pwr);
>> +		return;
>> +	}
>> +
>> +	requested_pwr = pwr;
>> +
>> +	if (set_bsw) {
>> +		if (bsw_val)
>> +			requested_pwr |= ISL12026_REG_PWR_BSW;
>> +		else
>> +			requested_pwr &= ~ISL12026_REG_PWR_BSW;
>> +	} /* else keep current BSW */
>> +
>> +	if (set_sbib) {
>> +		if (sbib_val)
>> +			requested_pwr |= ISL12026_REG_PWR_SBIB;
>> +		else
>> +			requested_pwr &= ~ISL12026_REG_PWR_SBIB;
>> +	} /* else keep current SBIB */
>> +
>> +	if (pwr >= 0 && pwr != requested_pwr) {
>> +		dev_info(&client->dev, "PWR: %02x\n", pwr);
>> +		dev_info(&client->dev,
>> +			 "Updating PWR to: %02x\n", requested_pwr);
> 
> I would use dev_dbg instead of dev_info.
> 
>> +		isl12026_write_reg(client, ISL12026_REG_PWR, requested_pwr);
>> +	}
>> +}
>> +
>> +static int isl12026_probe_new(struct i2c_client *client)
>> +{
>> +	struct isl12026 *priv;
>> +	int ret;
>> +
>> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>> +		return -ENODEV;
>> +
>> +	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	mutex_init(&priv->lock);
>> +
>> +	i2c_set_clientdata(client, priv);
>> +
>> +	isl12026_force_power_modes(client);
>> +
>> +	priv->nvm_client = i2c_new_dummy(client->adapter, ISL12026_EEPROM_ADDR);
>> +	if (!priv->nvm_client)
>> +		return -ENOMEM;
>> +
>> +	priv->rtc = devm_rtc_allocate_device(&client->dev);
>> +	ret = PTR_ERR_OR_ZERO(priv->rtc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	priv->rtc->ops = &isl12026_rtc_ops;
>> +
>> +	priv->nvm_cfg.name = "eeprom";
>> +	priv->nvm_cfg.read_only = false;
>> +	priv->nvm_cfg.root_only = true;
>> +	priv->nvm_cfg.base_dev = &client->dev;
>> +	priv->nvm_cfg.priv = priv;
>> +	priv->nvm_cfg.stride = 1;
>> +	priv->nvm_cfg.word_size = 1;
>> +	priv->nvm_cfg.size = 512;
>> +	priv->nvm_cfg.reg_read = isl12026_nvm_read;
>> +	priv->nvm_cfg.reg_write = isl12026_nvm_write;
>> +
>> +	priv->rtc->nvmem_config = &priv->nvm_cfg;
>> +	priv->rtc->nvram_old_abi = false;
> 
> If you have a look at rtc-next, I've just changed the API so you don't
> need to keep a copy of nvm_cfg. You will need to switch to that (at
> least call rtc_nvmem_register from the driver).


OK

> 
>> +
>> +	return rtc_register_device(priv->rtc);
>> +}
>> +
>> +static int isl12026_remove(struct i2c_client *client)
>> +{
>> +	struct isl12026 *priv = i2c_get_clientdata(client);
>> +
>> +	i2c_unregister_device(priv->nvm_client);
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id isl12026_dt_match[] = {
>> +	{ .compatible = "isil,isl12026" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, isl12026_dt_match);
>> +
>> +static struct i2c_driver isl12026_driver = {
>> +	.driver		= {
>> +		.name	= "rtc-isl12026",
>> +		.of_match_table = of_match_ptr(isl12026_dt_match),
>> +	},
>> +	.probe_new	= isl12026_probe_new,
>> +	.remove		= isl12026_remove,
>> +};
>> +
>> +module_i2c_driver(isl12026_driver);
>> +
>> +MODULE_DESCRIPTION("ISL 12026 RTC driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.14.3
>>
> 

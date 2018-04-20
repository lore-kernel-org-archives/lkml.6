Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755011AbeDTN2z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:28:55 -0400
Received: from mail-eopbgr40127.outbound.protection.outlook.com ([40.107.4.127]:34944
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754977AbeDTN2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:28:51 -0400
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=axentia.se;
Subject: Re: [PATCH v3 7/7] drm/i2c: tda998x: register as a drm bridge
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180419162751.25223-1-peda@axentia.se>
 <20180419162751.25223-8-peda@axentia.se> <2556566.3fxMPoIyx0@avalon>
 <20180420102408.GW16141@n2100.armlinux.org.uk>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <790d7a89-ae13-098f-3c0c-a8dfbc84e4a7@axentia.se>
Date: Fri, 20 Apr 2018 15:28:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420102408.GW16141@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::16)
 To VI1PR0202MB2783.eurprd02.prod.outlook.com (2603:10a6:800:db::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;3:x7ElPV5a9FS4TzD3DKwIZO71fVpJMSq9i7trZ5bc530jpdC4qjso9h2up/d02cICuGtyvoRyCf+8fN/qsfXfFlj0iMr5xBRRRaSTSM5XFruJ9Wi1iCikCqygDKPArtxmvhCN3smhFcVAUHpL/x9e/drWNpH4Z+DN8uocoiErvIw6BRJ9+eaJEZQujrU7Py0bN4FA3Yw9dgXihUW8C/zIsfSfVpvGdtwFBNT8mt9YHB9QTtFs+hgcbryBDHloskv1;25:p9C7uTUTsESBPhYiVgzM8Yb7s8zRjebSsFh2ziIZJxPGkE88YzJltabWmEA6PjM/Ah+5t5EJK4XFQyeRzpnH9USWQtj90GVPB3BE7x5dCP+WxWd6Uu03pZPgtJAZEx5yDioeXW2F7l1SCphOjjmDoIz0REH712VecBsDD1HO7sv2F0REsa2EDbVWWfKcvP84zJWJlE4p2wUW9l3YGiN5KqgMe+Pey0mI5j8IqP/mV5DSA8zOkWE1sDQsjE6N8oE3rHEbFctoGBG7PcExPkYhdvnYSXp9ASbY/zNR8LW9XEsL16o+JSMiRtgArFW2t146nm4OOvbRAq+Pdtz/prklfQ==;31:VC1ykox6z7fcCkujxAzSp3l9zYvi5Rq0L184Xft+Anq7W+GtVJ9IiGXzhOty+5agi/lOIOZGkCKO3fg+ZK54SmwaQJliK40gYS6dNu/5m18XdoXmR9c0dfck8lErqsq19xjTMmcUBSeW7NWS3/QZXE/wzkoH7zPlQS65A1+QsRta/ez7YhXxvAZ0NvEbHF44lTy+vfwk11bl60FsMkBJ+PSLOMkW0ohNkucorFuWRWQ=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2783:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278332A504619B58393FBAF2BCB40@VI1PR0202MB2783.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231232)(944501327)(52105095)(10201501046)(6041310)(20161123558120)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2783;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2783;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;4:MO2OrPAU4iVPgFSyT7/6LJKZddajPbdt2wvyvqIh+1u/pX8laxOuN/DByF6uDEyabLPRF2TxXxD2lwJk8fA1aWZ+R0tcufVbfEYgXY4flQdXo3tDsr9z9DMf2momj4TLfAweJf7KKFrz3aksUPBBWdGk/pAm2nC5vzLJIBHMyGTwbziA1bHdb+ls1x/zri2kMaQcrfQCOKao3GxScyf8FNTCr3p5187reI5jnnWQdYailMcBv5ZWPS4xGDIb95iU8mRTCtfS5e7Pj0U/U9NF6OpeDGhmLeiiafh3ScEz8KM6RhlM+D6WGR6mv2ukFMaW
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39380400002)(396003)(39840400004)(376002)(377424004)(6486002)(2906002)(36916002)(52146003)(229853002)(52116002)(54906003)(2486003)(23676004)(478600001)(31696002)(6116002)(31686004)(316002)(956004)(4326008)(2616005)(25786009)(65826007)(76176011)(16576012)(6246003)(3260700006)(50466002)(74482002)(93886005)(5660300001)(3846002)(6666003)(5890100001)(86362001)(117156002)(7416002)(8676002)(66066001)(476003)(446003)(8936002)(81166006)(305945005)(11346002)(26005)(16526019)(186003)(345774005)(77096007)(36756003)(7736002)(53546011)(110136005)(53936002)(386003)(230700001)(47776003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2783;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODM7MjM6dVRVeUYxN2RrVWF0eVJWRmwvYlM4b2w1?=
 =?utf-8?B?RkppN2FSSmZuMHRLRFR5ODM1R3JXc1hvbXRDTUhqbWJDZUhqWVBsaVU2allp?=
 =?utf-8?B?U3FUR0dSS3hZSEJoSDhOTE9pb3JURWx0TE9LWU9hUEt6TjZYTVdiTFVlR0RR?=
 =?utf-8?B?VnJnSlN1VFZiZDBoZDBIeHNKNGFDZjZZR1NVazVQTDhYOUMwYWd0TUxrL3NX?=
 =?utf-8?B?Q29NQVBlOGNVTmZ2a1JZU0N3akFuTWQrdW1USDhrVmVFTmxObnFzbG9rNENO?=
 =?utf-8?B?MzNjWGwxT1pmLzFnS1hxWDE3UHQzZ05yR0o1bmFCNnVvNHVGWFBUd2JiRjk0?=
 =?utf-8?B?YXMwVHJNdDk0Ync4ekNYTGkra2ZMSDdrTlJlaUoyVGlPSFNCbTQ0c3FqRjNu?=
 =?utf-8?B?S0RvcjBWc25KcUJldnpOODQ0eURneVR4YWJsRkc3TWN1N1VEUk1ycXFKQWwz?=
 =?utf-8?B?M1dMWjJhRFBLK0dybllHZUZ2SElidGk3WHBLYklmTkFYb3dTbXYvTy9sbmZP?=
 =?utf-8?B?TGxqV0U2aTNYNWRDN0lFdUdWLzJhK0tXMFJJdGdjQTZYS3hWTDdNTU9TcVhR?=
 =?utf-8?B?cVF2VURDaS81bGlIQWpaM2syQkpmWnd0RTQzbmpvek1FQmkxYmRMRGQ1b25L?=
 =?utf-8?B?ODhrTWk4ejZsME1sNVU3ZGgxaVNHNmFVcVhWU1Q0S1VwUEl3N096L1RGRTFZ?=
 =?utf-8?B?L0xBaEY2YVJSc0t3MnRpOVdpbERxRTljWlNMWVNYcEswMUtvaGVPSDM0Visr?=
 =?utf-8?B?bmg5Z1BnWjJBV05GTlQyUTZkR2RGYzFkN1M3RVdFSmRKSUtCUHFFUitlWHpq?=
 =?utf-8?B?U1ZybStNS01DYzBiblJQU2pkNUZBbTNvK3hIenkwNnBvcTJmc2JubmxIa2xw?=
 =?utf-8?B?Q1B6U0YwZWVRSGRvNlN1bEk5SEFOdzJGcFUyaW9oUlpFY0xCK3hJUXdRL1RM?=
 =?utf-8?B?WGk3SW1TYmhvbWU4VW5uNnhaN1V2RTQzd1BUV3VGYk5OdkZOY0pKRW0yd3p2?=
 =?utf-8?B?WFFyQ2NEcWJ6K3lXdjZzaDFac1J5eWZZeHR0NXVEcVRybHEzc00veno0Uk55?=
 =?utf-8?B?c3k0UW9FMlc4VUxaK0g0OWlObFhXTGxrZzk1aDltSVNjZGxMd09ucWkybDlz?=
 =?utf-8?B?by9meEpGclhLeWJ3NTZzWmRvR2kzejYrYlRKaTlvL2ZwM0pTNFBWYlV3REpX?=
 =?utf-8?B?SDR5SG9JNE94dXQvYU1sSENtRnlKOWpmMjRWTXVnNkF6cCtJSHF1SitBNEtZ?=
 =?utf-8?B?dHRFOWhMZ2VpYVY4REx0VFdSV2hlWU5BRnZqb3lHa2R1Ulp2UlhQVWpuTElQ?=
 =?utf-8?B?SUV3UG1kTmhKVU9HZ2ZISWNBajRySUp3QytDd1JIVU5YR0dQckhGb2s1ejR5?=
 =?utf-8?B?dHJsV3hJU0lGeEltc1lkbnRNSWlLUko3aTNVTUlRTDlrdG1XVzVONS9HdVkz?=
 =?utf-8?B?MmhRczg5VG9ZV1FySHRQUWdPTFdvT3EvdFlUVWR1aHg4Q20zNjFBL0pDNGVL?=
 =?utf-8?B?cVZ1SXNsZ0t0ZTN2YUdrOUtTSlU2ZXhRdUw5VVlRZkRTZHZqbXZIRVM4eWth?=
 =?utf-8?B?a1ZKbVUxYktOTjRLTkwwWllidVd3UGp0ZTMrcnZ6MnpLbXhKVzE2Z0lQVURR?=
 =?utf-8?B?WGRsMW0rVlNHb005OUJBd3dMektjUUY4YUltdEtrNk1iQnJXU1hHdU55ZVdr?=
 =?utf-8?B?WTZsVEphdG11RExDaUxIUVR3cnpXbTlFWHYyeHBTcmlROXhHajgyNWsvRDha?=
 =?utf-8?B?RzF3OHRBc01jakR1a1NTVFQ2dDU0NVdEWXdtMjg0YURiMDBRZWFaWUdiMysv?=
 =?utf-8?B?a1RBWWpEY3lheHk5VmduNzVuQjRpTnZ6U2F1d0RJWjFvRHc0K1hiOFArbVVo?=
 =?utf-8?Q?QeTIfIioc9XeO8H9zoWUS65tR7w7tNpoVv?=
X-Microsoft-Antispam-Message-Info: 3kH/2J0YI/GLGDnfZ3ZyBmyZ7mB/L/EfRZ6rR5Jwo/uXtM+B3Ky4aqba687duQR7YVonKmmKpc1yU5UgWnPKJNKSXsKF/aKdL2Nfgm2tHOaSN8JZ0WCis8dfJFi2pPjJB7rNHscYF6Pt1oUQTMt8FEgKNHHsLzr1xCQ4dCS9fmvjPFduEazUyvbn/4oUaE1I
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;6:khXUyIkI/EpIK9c3CDEvBs4E8oJdi8/U67HHRv6L4Ih764ANOXobyZCc2uSSXFGQ5LNdjTz1qdvBNDeK3YeLGZ0YZFMJCGIptWNbiONSfi8vC2jYS+sSc0YqqqN1MLsTHaIdU/O2phmjc3oYEW9i2N29LBR+tsNtXfO49tHcPOafBDbv6+T3HuRE2/aDah6J5RT5Xbz6NJnPtDIUfN7OGvHqdBh4jefJgoSUuauJ3Jkmf7htZzfevIkjb2TxDmsOxNmJ2JdZbDssVpLb6HD3NxZP1rdU4Mg9ZkF1y3CMkQMtu5ghyu5ebCibn+ImsWToi4tYeNDRuz1v9xiIpEzVc9Nc8nAWXZ0jfXj1jakC243elKRNSmWmqbqcDDb60SF0tG/jIyL0Xac4LVEEIfcvXCcBeWecpDxKDU/ccDS7aSIYSjquS06sM0/9b35gsQjSARDeaPXb7zAQtGqx/AgCnw==;5:UDbsvEYYbIDFKf9Ke/gWSG7PTYMgbxIuK5kFgifhFvYvyuIosvY/a6evs+Xfee+aPOhU2FpsTMsQo7kanvfbv80ivgT+kWGEMXKjhx7em+FOFtjRvM1j92Vl6RAQ+A/iMyyjg3hOo5SifpsFhQdy/lvqNIUnbCjokUOlor/z8ZY=;24:ybxU8x3E0FuZGNR8WuFOghyVmpmOzb/loq0LSYT2eBYNkvp3gxhT4vkhqEr8S6LvgZIUX7XZSjB+05Kh3gsN7BdGn/dBNi1+NMcgL3U+pyw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2783;7:tg24IJzimoBJhCBL0maWlKT5q/FB8VsdFzW0j65qT7rfU/9EUHfpL7NCteryjhZzhaOTO/R9TAXlfgYIk1xpjazmOH8MUEEwAhjuGj51hBLMQHW+X5g+NqiihXCd8UOYEBOoc5WRb8B3jkQucQPsO9t64+woMzoGNBf5EdOf2i+BJFiLFv2EmTfJMcjA0I9V0ulpdOTdmKWM9d8LjyquGTM0YNgy1ZUunnoL0Asd8iaK42w/wyFREimRCWMsSLst
X-MS-Office365-Filtering-Correlation-Id: 143b8563-5799-449a-a2bd-08d5a6c2a59e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 13:28:46.2015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 143b8563-5799-449a-a2bd-08d5a6c2a59e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2783
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-20 12:24, Russell King - ARM Linux wrote:
> On Fri, Apr 20, 2018 at 01:06:49PM +0300, Laurent Pinchart wrote:
>> Hi Peter,
>>
>> Thank you for the patch.
>>
>> On Thursday, 19 April 2018 19:27:51 EEST Peter Rosin wrote:
>>> This makes this driver work with all(?) drivers that are not
>>> componentized and instead expect to connect to a panel/bridge. That
>>> said, the only one tested is atmel_hlcdc.
>>>
>>> This hooks the relevant work function previously called by the encoder
>>> and the component also to the bridge, since the encoder goes away when
>>> connecting to the bridge interface of the driver and the equivalent of
>>> bind/unbind of the component is handled by bridge attach/detach.
>>>
>>> The lifetime requirements of a bridge and a component are slightly
>>> different, which is the reason for struct tda998x_bridge.
>>
>> Couldn't you move the allocation and initialization (tda998x_create) of the 
>> tda998x_priv structure to probe time ? I think you wouldn't need a separate 
>> structure in that case. Unless I'm mistaken there would be an added benefit of 
>> separating component and bridge initialization, resulting in the encoder not 
>> being initialized at all if the component isn't used. You wouldn't need to add 
>> a local_encoder parameter to the tda998x_init() function.
> 
> No, I don't like that idea one bit, as I've stated in the past about the
> component API.  The same (probably) goes for the bridge stuff too.
> 
> Consider the following:
> 
> Your DRM system is initialised.  You then remove a module, which results
> in the DRM system being torn down.  You re-insert the module (eg, having
> made a change to it).  The DRM system is then re-initialised.
> 
> At this point, what is the state of variables such as priv->is_on if
> you allocate the structure at probe time?
> 
> What about all the other variables in the driver private structure - are
> you sure that the driver can cope with random values from the previous
> "usage" remaining there?
> 
> At the moment, this isn't a concern for the driver because we
> dev_kzalloc() the structure in the bind callback.  Move that to the
> probe function, and the structure is no longer re-initialised each
> time, and so it retains the previous state.  The driver is not setup
> to cope with that.
> 
> So, to work around that, you would need to reinitialise _everything_
> in the structure that the driver requires, which IMHO is a very
> open to bugs (eg, if a member is missed, or added without the
> necessary re-initialisation), _especially_ when this is not a path
> that will get regular testing.
> 
> If you want to do this for a subset of data, it would be much better
> to separate them into independent structures (maybe one embedded into
> the other) so that this problem can not occur.  That way, a subset
> of the data can be memset() when bound to the rest of the DRM system
> ensuring a consistent driver state and still achieve what you're
> suggesting.

This was the exact reason I added struct tda998x_bridge. It seemed
very risky to move the tda998x_create call (or some of its meat) to
the probe function. Even if that could be done I think it should
definitely be a separate patch.

Cheers,
Peter

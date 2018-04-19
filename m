Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754064AbeDSQkM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:40:12 -0400
Received: from mail-eopbgr00131.outbound.protection.outlook.com ([40.107.0.131]:60000
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753622AbeDSQkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:40:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 3/6] drm: of: introduce drm_of_media_bus_fmt
To: Rob Herring <robh+dt@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
References: <20180417131052.16336-1-peda@axentia.se>
 <20180417131052.16336-4-peda@axentia.se>
 <CAL_JsqL1=fzTb5dUgrj07Jv3r026ndsU2o=Nr2eft-bni5jueQ@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <3181dfde-cd19-41a1-6e6d-5be7a9e40674@axentia.se>
Date: Thu, 19 Apr 2018 18:40:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL1=fzTb5dUgrj07Jv3r026ndsU2o=Nr2eft-bni5jueQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0501CA0019.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::29) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:++zMZfh2Qo8ZKuiXXKephCUVZXeWTKigme+WnRadA0+aJzFcdWuesdYs6ED7M8zaj69+AQtmmfAgW75vs2945dRuABwjrQQs9WmDf0BMYzTrnXJRQuGaPXW3Iasfu7BtGih7YZTSPARDQ3LB34tzxXmS+Vrlya9hJWR9r3WyW7izwRU6UIp/9LVY7x+H1SoTZKrop45R4st2jz+S0f4+LvA0YVAXnigkS0KsW+61QBHylvL7Y2duwPWtwS3/3iuG;25:AUeMnVVAuw46FvsnJzYGa5dBTotc/tqWBsmTZB2CKfv+dZJcR7pFn4bG+r+8lhyl9nbT6xI31I0n+rf6iYq7pYvMDSsMEg5Dep4tE/AExUhs/uyicTZcaDR6f7Ons7Z/gQ02bGSWT4zLNmQGMjoMUqEBbOv0rRrHkTxMzMN3s9pp3L2mgghmAgQUW7B02i2oABdq0T/QD/GSThf9l8R1osWaD0jhm3iombUYDp3MA0rgjoy7eSqO5X3JGoehDhcWy7Gl3imyl2I3o4L6risygNuoTdFhmkZ8Iw/N9AJmhP6kQEXcA9TCAG3vu7fLMwF5PZDZa+XBqMbf/86FFA6hGw==;31:tS2QTC9wm/yp/wu7u5bqJdGzWnXm9tYW/O5uSfzjaUgQcWWIcT3Qx8ySNYPIzMDgNWieC3IpH2gAVkaxXLmZJCax5ycxr7kDx+lBKx4uVqkLdg88Sj+vTKXeadIW86iC9/sGlbamA4LumEdgYz3+ZUqYrndA7femdthaYO0V7+EKc6n3Vpq0EpGLqXh0nCaTGEYUXrWBYy+/xr95ZnxIKPXrSlbL3HjjsFgIQueVeX4=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2779A6D77B5A087DF201BC03BCB50@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:FTUnSxJaUNto7mWH7Q/dL4RBktaDfVeTwxEL2vVMHlcYKQ+GYIR3EW4kJ9hLgAdruFJFHu3G6FpwJKfPCAgvU4FRXhLyAG/h+rrP7CGkZX1lHskdWdvx/8VGCmtmPQUJRsAdOhwasvRFmCQ/TCiTtk77EqFVVAnzIzCe6C227iNMZpW3dbOiZxWaCUMCJj9hY/FVD1wGWC93RjUGbTL1pQ5WnApwRpYhguZf/jwgVUwjkJL0jIOxF18ONHqSm9tEfPwae98v8aNiS8lScrVBGQ==
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(346002)(39380400002)(396003)(39830400003)(366004)(376002)(377424004)(52314003)(6486002)(3846002)(5660300001)(3260700006)(50466002)(230700001)(26005)(478600001)(2906002)(86362001)(117156002)(77096007)(25786009)(31696002)(6116002)(16576012)(66066001)(36756003)(65806001)(7416002)(65956001)(305945005)(8936002)(58126008)(53936002)(54906003)(8676002)(74482002)(229853002)(65826007)(31686004)(446003)(81166006)(53546011)(956004)(11346002)(76176011)(2616005)(36916002)(186003)(386003)(52116002)(64126003)(16526019)(6246003)(7736002)(23676004)(2486003)(4326008)(47776003)(316002)(52146003)(6666003)(476003)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzk7MjM6QlNwNlh2b1dYL2Nwb1N0N3R0MTJHcnlC?=
 =?utf-8?B?a3R4aVZFaHE2cGNERjQrQnV1RDdMRVQ5RW5wSUF3clFqeWpqbG1sTzlEcXFK?=
 =?utf-8?B?ZjBDalR6dmVUTVdDU0FVa1dkWVJXT3RHNWFybWpUdkxpUTJTWU9RT1dzRzF4?=
 =?utf-8?B?TUNYM1YrN1padlFxQzRuZDcrZnNZTk5VQktaMkIzWlhlRU1tVWpaVE1NM25X?=
 =?utf-8?B?U2lteXU5SnVsclMrYWtGZGZhTGlabzM0dDFWbFlvM3dWV2d1c0xDeUZteXNR?=
 =?utf-8?B?a0pCcWJzcGZXSDRRcVludkNSQ2ZYcy92ZGo2WlhMeXUrMzNHeE9MNThMNXRV?=
 =?utf-8?B?bmNoRGswYndGTXBDa1U2QUd0UElaZVowZXUvdWt4MC80VXNOY2pob3NRMWpP?=
 =?utf-8?B?eE1wMjJ4aE1UcXg1akNVeHE2T3hTcjI5dnlUajdjRHZRQ1l5MU9RQW53U253?=
 =?utf-8?B?Wlgxd2NYbjRTVFhTSm9ockhPUnlmaWFzbXlPbjdOZUlnMFhYUWJIUHkzTFVK?=
 =?utf-8?B?Z2NUczkrWGtFeCtUOFp2bjZneENHanRVOUhoTTFmQTRsY3FFbnpyZ3RKZ0l3?=
 =?utf-8?B?L1d4UXdmWXVvSnF5MlZYSmdPNEM5YUxZMHFoZmxDemlua1VldHpWNmdFVWVC?=
 =?utf-8?B?TVlOZTRIVGR1SjBneGI2K3Q4VjNPcm5XTTltQVpZeE91VnRhTkZtNDhqQlVY?=
 =?utf-8?B?dUdjTGxQZnhkOHFSaTRZM2pkMklRVy9JRGcreUxJSUhyaEw3WTc2dkxCeW1h?=
 =?utf-8?B?MUxVWWRGc3JVblN0UHNzcnJ4dWZOZnYyeElXVHpiRkVQaVFscWFPSnE1V1hK?=
 =?utf-8?B?WVJUNmhmT3VBN1RLTTdOU0UzQ0VZd3dYdlhiQXhDVlZnRHZmYm1nZWtlME9J?=
 =?utf-8?B?a1V6RUpUb2JoNExXT21rMnBBSHc3a3ZjTjZvYXJoU0dKUVdBR0EvVFgvdG9F?=
 =?utf-8?B?V3BOWHhEeTZPWnhZNmEyQ1UwOVl5OEZtR2lHYkNPZFhVM3phRFBDbmpsSXox?=
 =?utf-8?B?Yjh4UzhwV1RNUTVCU05mUGxDWDNmdDUzdUswVklRK1Q1SktqMlVWSGMwblNy?=
 =?utf-8?B?KzIrdE5OSjk2UzRSTHlVSmlPT3JISDlBcnRURS9VMVBrUmpnR0RKZTNjajFo?=
 =?utf-8?B?U1dNbS9oK2FzendzMDZWYzFaNWRZbTRjYXVyYVB5Y2tYSEV6dnlhNVhMKzFa?=
 =?utf-8?B?WHVvZEVJanp4dFZtajBOcEZYUExyOEhzKzkvNzBCVVZRVjY1d05nQzd3U2lQ?=
 =?utf-8?B?UGM4QS9yTU5FUTBTclhoY2RVQVhvRmR0dkd4MEtMNUxjQzVWWWJxc2hsRlpB?=
 =?utf-8?B?TTRzandSOFd2ZlIvcnRmdE5zZ05IQkhESWprbEtCcWhmK0dTZEtyV3p3UWx6?=
 =?utf-8?B?Mmo5M2puUUdwUHI2MEN5RVZocUZSWXlEWlMycGhUZFBWdisvbGFjcWs0S2Vu?=
 =?utf-8?B?WTZvRm1MVUJnNXVnTjJVM0JrSWtpZC9sNUlwbEV1bEFZV1c2MzFmR3ptb2hF?=
 =?utf-8?B?R1RRS004WEhENUEvMTVrL05TSFVsbUhtNGlDVjJBSCt5MXRHQXN2L0VJV0Zp?=
 =?utf-8?B?WWpiTXhQQVBSSHdGZlJzQkR2aDRGaGNjdTk5Ty93cUNNeitNUXhaNlBXdTNF?=
 =?utf-8?B?SEFoQ3ozRXFsUDNraEw0UEVmbWQ1TmJXRUlWTUh5QUxMWnBhRlppK3ErM0hO?=
 =?utf-8?B?VFNoaHJnS1YvcjlKU2xEaTRwbkFYRGNWaWl0S2VkMmpxVkVUVlZkd2hLZWxn?=
 =?utf-8?B?aDNCMVRwM1NTS2dBaUhqbFEvM3EzL3RvNXlFcXFUMC9TbitoRXBDeFBTT1M0?=
 =?utf-8?B?aVNNOFY1eXp4S204ZnBVV1Bhd2p0ZlZLbU1Ldyt6VjFXZWVRWUFBWG80c3Bq?=
 =?utf-8?B?dmpLbjBLaVh4MnNiZDFmbk1oVW8raVFlTHF2RWpqcUlYSFpza1IzSkxhczhy?=
 =?utf-8?B?NlVwSEpWMnVyQmZpVTBlOXV4aloxMjlSREQyREw0WHE3TkdHVklRblg5RGRK?=
 =?utf-8?B?Q0ZhVkVHZWZBSWdENy9qd3Q5d1podGRURmR5a1YwZE1XWWc3c0RHQWFzVE85?=
 =?utf-8?Q?c13JaLg9B3rPAdqxLpq6Q5Wbi7w?=
X-Microsoft-Antispam-Message-Info: pTqJKWe5Sq8zSfjrsec85dP4LOTSdnurNJyExr9q+VUFjvJRP7k8SWr7RDct2UZIYRxKhPJQp12zPoNSkcngjIqXAHsssdy7eJrVD1vflehRiEBYjQ6rhjUsT3O7ki2lZ8tndCa/ILvr3IhMH7bmRPO5GinEreVn7DehqKEq2CRWa4wwdNJxa4pyD3vQTAHK
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:4uovPWD5pEwDYA7jNJcr6gSeXpXH511sF/ju7YdWuuMLneozNNbo5qM5kyRtNuBzWe/tLR2dzKj1KyjS/QHIMDu6VKcm2Y4HfwnTxQLLrDuiHK5h1Pl6y6VPzC6KEh0X4T+rZ5QdmdhYZnqL+2qnEDxT5jkw+6y+VCSJb3u4MfpvchGal6LBNLa4URdIkBJcOTxbk0PchwvKLrolop3ECKFG+q/1JqaWWg6/ruRt8zNN3l0ueqF39nYejfn8sZI996Eei4cBOW7GAUgdiLFBJTTiRce8zXFRZ1IH+BjC18uePSad/vPFKGp3roygNwudhPJEGWEcIGN+47JVSbvd2n51lDsLtG0hNzSNMGzBoDx6JBW1O4G3naXV2PwFgdlPCZq693eWNVS683TI7cPWIsWfGXS0dkOP+SxFbY+S/4/cmjsXn21Q7v4/YiwYAsleZcSejfczXIcAtXoGkSIWnw==;5:J9jgaoamYaix7i4fit096uWUSAS9pBx/VDvbVBtE56X9oNX+yad/MhGtNFDMKpSGkisIENseU8HVVX1hFzMs3wg0mOqg0gCvpmbMj/GfuIswvGCIXLIvhzgnQr4haNaqnOfISb2BANWJBqo5x6psAQnyAbgsOOovbPIp1o5Arvs=;24:d8J7I6qbXfzRdLDwFWm+i06ks81jXDxd9NRDyxPPoWBJAzDoEn/G/Keoy9ysClsjO3K0g8ucIfig5Bg+uGarWmlqPNErDSl0JfMdx0eWjZE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:TN7ozfLg2MIYamMVF5GV2t3hY+TXJxWyGfU33rBxgMdzjamiiHBcSJ52+hOd15m06SgMRgc/Mg55mYe4tjbIrhMvDennJrUAVLp6hUuogs9v21yCPCXw3ThMp2QGS+thmnL1e4/TZIUTeJY395TA/a3OIjcGH+Yh8vTtq5CNM3PmZbqaG2Ihd40QEq10mokyyy4M64rQbqqRvq06Kpq23Ff59KSdnjyKCWDUOVJNfq17/R1GTQfgptJWBoQHf49d
X-MS-Office365-Filtering-Correlation-Id: 6285d824-b8c3-4e84-ebf8-08d5a614348c
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 16:40:04.8375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6285d824-b8c3-4e84-ebf8-08d5a614348c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-19 18:22, Rob Herring wrote:
> On Tue, Apr 17, 2018 at 8:10 AM, Peter Rosin <peda@axentia.se> wrote:
>> Add a central function to parse a node according to the video
>> interface binding and get a media bus format.
>>
>> Start with only supporting a very limited set of a few basic media
>> bus formats.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/drm_of.c | 38 ++++++++++++++++++++++++++++++++++++++
>>  include/drm/drm_of.h     |  7 +++++++
>>  2 files changed, 45 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
>> index 4c191c050e7d..f9473edb60a7 100644
>> --- a/drivers/gpu/drm/drm_of.c
>> +++ b/drivers/gpu/drm/drm_of.c
>> @@ -212,6 +212,44 @@ int drm_of_encoder_active_endpoint(struct device_node *node,
>>  EXPORT_SYMBOL_GPL(drm_of_encoder_active_endpoint);
>>
>>  /*
>> + * drm_of_media_bus_fmt - return the media bus format described in the node
>> + * @node: device tree node containing the media bus format
>> + *
>> + * @node is presumably an of-graph endpoint node.
>> + *
>> + * Return the media bus format, or zero if none is described. Or one of the
>> + * standard error codes.
>> + */
>> +int drm_of_media_bus_fmt(struct device_node *node)
> 
> Should use endpoint or ep here instead of node to be clear what node
> this function operates on.

I just sent v3 and missed this. Anyway, the reason I didn't use ep,
was that you at one point said "port of endpoint", and I wanted this
function to cover both cases. And maybe others. Anyway, if I hear
nothing I'll make the change to ep and I'll also reword the comment
to talk more decisively about endpoints for v4.

Cheers,
Peter

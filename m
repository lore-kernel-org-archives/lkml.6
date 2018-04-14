Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbeDNNye (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 09:54:34 -0400
Received: from mail-eopbgr00104.outbound.protection.outlook.com ([40.107.0.104]:46344
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750914AbeDNNyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 09:54:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 2/5] dt-bindings: display: atmel: add optional output-mode
 property
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180409105918.20792-1-peda@axentia.se>
 <20180409105918.20792-3-peda@axentia.se>
 <20180413174648.zxljbw634o2r4zty@rob-hp-laptop>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <3bf87960-06f8-3224-10d9-4ad76ff446a4@axentia.se>
Date: Sat, 14 Apr 2018 15:54:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413174648.zxljbw634o2r4zty@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0701CA0065.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::33) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:1RB7yfQx06wmLd5uTu+PQj10i+fWI70B/tdIAV11jBlwIfwxhyJuFjr7KuXf0QnzGIZNL5GlBbs0oappiODw345lDm5EKoJOTq74nlPE6NJjVl7XGPPawHQnDEdkFHlySQ5mDAeOP8jinoNmGiFOY0HcGlZ3hbJ/12l9nnbLsb394vExdTR79cxZ0wP7R+9DAqNvAvJc43EtGT1QKP6d3ghRbdSCPoLL6ZBnRCQYHX1ulu6FR2uqNHf46H4XyMTZ;25:KPoskFy6VPeCdVkecVpNQ/toaDmpHf6xo9pdJW/PqFA8L5MohgulZ1oAOeYZbdpNjmkE6iCayS9GZLMLr95pHJUnz7aotbPMe8rUUc9/ytdgidrRisDN+ayo2oigNr6YtwCxFEsBI25JfJjb06GKj31OD7FJ89+Py7Bj0Urpr4ApLpkdYMAvimrfcwXLicFgxQ5GD+K3xqFqoCeLDp219+Th/F1Mq1fnUnMMnRoLF0oJBqswg0D7GSAsDGN5SsqWMHmoXcyuyXnU3YxYnH6kmxdn61HAFypIwxJSdjpAYjVGwMldgoCntRNwVMV3pR4wwxDwCmfWdLyQWK4hxpE11g==;31:Q0mxPc7sCpNbE3bSMpFqE1Yq1USdYeTg7EaRYlWOn3cXHvYoUCxeS2sMHAyiHKrGAvc/8YmJgwhnZ6oL6fPD7ijlA/UJzAP6Z1dmUFvEhaQXn5lZbpJQ1xY9iMWmepI3D/BakvyNeLjIWI62pOUAGR5fcLQ8clJ+Kt8VGh/6ACjNEGFk5xVTSVGnDe4Xl/1JkeHW9Efnx4nAi3JZLrVWlU1LoprHGACbPRa98qe6nKs=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27753818DC5A617BA63AFE40BCB20@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:gliFMoe4CaNY8zwVaV4upVyGor/xov1W82akl034yX6EQvRVw+7HTcWl7CLQmI90XKR+pv0jHdVOo4tc3IdZf/d1xq+khDO9AQZ1AWrmqaj9GPdHoXkkgcclJwK6UFeCH0/ImsbQ7FWXcUJWskk0lkeHvNtq4zOHIqYzR7CEnighHsHfqWjmon/ROZmWZFbhD3wmK/EI5a98wYhnJ6dYiz4THR49iWwt/MSAq+I1+zPZGxQm4G29UhjUZx6xLcp0k0ZTuF3EUck3h4dJUGgWoQ==
X-Forefront-PRVS: 0642A5E7BA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39830400003)(39380400002)(376002)(396003)(346002)(189003)(199004)(377424004)(77096007)(7736002)(386003)(486006)(53546011)(476003)(86362001)(97736004)(16576012)(316002)(2616005)(956004)(25786009)(3260700006)(230700001)(117156002)(36756003)(81156014)(52116002)(2486003)(4326008)(8936002)(53936002)(81166006)(8676002)(36916002)(52146003)(186003)(47776003)(23676004)(76176011)(65956001)(66066001)(26005)(58126008)(11346002)(31696002)(446003)(68736007)(16526019)(6246003)(3846002)(305945005)(105586002)(65826007)(31686004)(5660300001)(229853002)(6486002)(6916009)(6666003)(478600001)(65806001)(54906003)(6116002)(2906002)(74482002)(106356001)(64126003)(50466002)(7416002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6ZkY1SHRsREc0anpYcWdoNDl1OUw4RC80?=
 =?utf-8?B?K0xWaENtU2pra0xGYXpONTNTWi83OEk0T1VUL2NXT0Ruc3lkdFlYZldwU0sz?=
 =?utf-8?B?ZkNSQkpMRUJrb2EzdTZ0VVNwZlltdmxFNFJBeXFKa2ZDdmM5RmhmWEZtY0o5?=
 =?utf-8?B?SThTMG9iRXlMbm5nWU16RXVDOEZCL29BcFhUd3RYSDRUQnR3SmpNOVFKeWlH?=
 =?utf-8?B?NFZaS0o2Y1dsR25CdnNOeXVMSTdmRUg1eU9MRk9YUlBXbU9YYTNzVG9Qdkww?=
 =?utf-8?B?QVVValpLUWZNMytHRUl5eE5HQkYwYXl2K0xoaWlLR2J1cFprc2JrMFpmKzZV?=
 =?utf-8?B?b3NkM2c2OFFPSGt1bloyRU5vTDFXNWRKanlFKzhER0JuRHZXMnA5T0hLU09k?=
 =?utf-8?B?VGxTeStsRHFJZWorOU9GWVdqUHlEdFpWWklaQTFzdkVaSXNydjEwdWNpeG5C?=
 =?utf-8?B?c0puY1BNaDNMSVE0NzNZN2srQm5FT2FBU1huankzUHVJUm5BUVhQK3FNazBO?=
 =?utf-8?B?K0FoRkF0bm16VGE5ZHM5cE00NGMxYTRZQUw0VG4xREx6MkNaZi9GaDRUTVdh?=
 =?utf-8?B?clF2T1VGZ3hkNzJsNFNBOEduTDJlb2lBeUZjMnBEQVBSNi9GWGg3Q21YVnI4?=
 =?utf-8?B?WnJ3K3JyNldzRU4zZlBuT0hTUkdrV0dDOXBjdi9UT2J6eCtyakFwd3RETnV1?=
 =?utf-8?B?MUlSR1h2M3RrUlJTR3FoUHpVWnlzSlZzbzE4aFY3dkdsMnd5MWtGQThSZkdZ?=
 =?utf-8?B?QmF2VHlYazFvYSt1ME1mUDN6c20yQi91ZXczajJzcVpLQ3ZYbjFlK1R5bFEy?=
 =?utf-8?B?cXFHb2hmVm8zQmcxWGdVMFpFTzBRUXh6cXZCTUFVaFZ3ZkVnelZPVk5BVHJN?=
 =?utf-8?B?d1FoVXpHeVRKd3FUWWp1YjhSdDVYWTk2a1lScjRPN2krOS9qSHQwNjFkZ2ll?=
 =?utf-8?B?ZjVkaGplQTUzeFF2SGtpdDUrYUtEWENpand0dEkwS2R2R3ZLcmlyY3Z5em5N?=
 =?utf-8?B?NkVhZUNJYUZvc0orVFd1OVlVeFZvN3I5TzF3Sk04MFRHTVoza3VtelNRSjFM?=
 =?utf-8?B?TmlnVm02VTlQMkhiTEN1dlUxeit5VmZLemJyY2JCVGlsYWowWlUvY0ROVTR6?=
 =?utf-8?B?SGFrejR5SkVGdXNuRTJseDVxWnhzOWJycEZhMXB4WmtuSHZQVVR1WmtGcFVY?=
 =?utf-8?B?SVpVKzdtNysvb2U2UWxMYSsxaVFScDRxT1lyUytmUDQyUjJnaU5SaGtybGZR?=
 =?utf-8?B?d0tGd1daYVgzQVo1NWdQUlVQU215bVcrVlBQNVRjWWNqYktFaVcwVmI3VW1s?=
 =?utf-8?B?Uk5tVEJuRGpVRmlmV1ZVS1Jrb2xjS1ZKbEpUeXNWSEhQWDIxaDMzeXpzT1Ey?=
 =?utf-8?B?bFpZQmI5Q0prWjdEV2d5S3MzZm5kTVFqai9XdGJ2dHRFbXo5czdDYWc5amNQ?=
 =?utf-8?B?ZWxkWlNrOXRPdFhnWmxjd3J6aXd2UXFqU25BN2Z6NUI0eHVVcjh3d3ExdFNG?=
 =?utf-8?B?eTA3cDdoTDJmQWNJaUhUUUpabEJXc1F1Mk9QKzAweVRyQjNrWHN6NC91eE16?=
 =?utf-8?B?M09teFNGYVZTK1lnUDE1SlVFZC85TWZIeC9BdnNoN2lFSTR0QU45LzhBc200?=
 =?utf-8?B?aDlzNlhDdnVMYUVxM3JxOG9UTmdxYnlDaTZqR1cyYUR6U2cwYzZZTWhZb29k?=
 =?utf-8?B?K2JTNFZKNjA1dmhUbVdPcnFleTJKa3pORmlWT3VmUjBaSHlSMGxwb01nb2lR?=
 =?utf-8?B?UEQzby8rR2owRU5Qc2tLbUM2OGdUZ2lGZWs5Sk9DT1pSRGJyZHMwOWhkVFpT?=
 =?utf-8?B?WFB3cmhaa0tYZldDTDJtSnhXcW9WYkEyOGk4bkszRnZBaklFSWNSeGFXK0Fw?=
 =?utf-8?B?WHp1Q2FUZUpjMi9PaUlPNjVneC9ySFZQNVR6VGdSaFpIM2VzQytYWCtzcFMw?=
 =?utf-8?B?ZDI3UDhFMlloTkR4REVsZFRveU9RMHNsK3JNYjRJRkhkYW9KTG5Gczh5SXhj?=
 =?utf-8?B?aG5KVmRWOW9iQmw3YVFZL3pMRnpXY1hqdVZVYmdRYzdkY3J6VkIwNElDTGto?=
 =?utf-8?B?bS9WeXE0V244cXRXdEQ2djhSTWJVVDRicUJEcllVMkowS2NIQk90WXhPQlFl?=
 =?utf-8?Q?5ZVCYfrav0DsNxbWd6c7c+hJZhIHdU64JzKyTeRY7MLEV+?=
X-Microsoft-Antispam-Message-Info: Ih6nE+iw9MySMHNsAHlxBXrZNbnOZjHHc524Ws72JnBL2HYwT3PubsnvyiqDQM3sc/IvlgyixaUuQRg1f6K4FRJDNBVsFLP97+rm582/q9uOKBrZN/HC84oYAhyflE/TE9C7dc+4qbFrxH1qhzGEDFMZYNrAnboUY2Be4xI3l8bZsCW8Zb/iBOi6Hgd48oYs
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:qptI0xtmEPHIMhRXUM6PtRdPx2oCkIxUq8F07q8Fr05xi66UBWfk3tj+0Z2lBM3jJc7Z65GSPyPK1/3Uov0k6KKikPAAQU9imso1CvzsmGOKguzlTwvka6dLAHUm085IfoUmp3K+P41hXV3ASMOXbKJyKD37zIfZwTCdvwwz+NP+jbCfJwdtwfBP4f8mU3F/rbRrWbeneLt0cxOTFVGRl2RrF5cFA3gxEvzuLi1ptx6H+F1/2HFy1Ror1D8kOPboVm80HZXork0rwveLb98wlYlA580N1xWd/aPC5yUjC73BwVk9tG1MVhjdqaZCxuWX9dviwC0iYpCIrsdXcd8SnE8An+tTKzvuT/niUjLNcgYwf8Au8o4eT62EuKtYCOeRZnctRCJ5Fvnf1GofnBE32sBSFSmcqrFbbyJuju9+w78VAKbGeTqzik8zjHd0oxgxge4wB3r5gFbfqjeIsc92GQ==;5:pckhPfop6+z51tTg0UEO4P2/s7OUlZfT7dLK0ILeK3B2ovlxwNUqH/OHqZ4jztOjssMwYycHv3S86pFM3ezELF/zNJcDz48SzbgPijUNhIasRbLlohv8vTI8vB/CAYx0OpaQY+ayF3s0Rfov5oaY87qncqOOPpmzN3St/jKxC0Y=;24:np87SGeLAdXeQdw1oFH69A84wyeApjZbRzsObpqaYV+myqohJ5SzH92WgbT14J8XNwQIXHIVjfg+sUjkMjIjgu2QSF8QWexnK4wQ1nxprag=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:O4V8um+5Ca6kIU02qGiLLW/g/rUVkatlYAf0tv12P6Clvm+DxDklq2kRmk6VJON/Z3B1n2q8Q58jabiRDCE0+LyWPqGibJOBCOIbDFQePJ0gEAmRCZ+DkdfHItYlh4TdR7rRLbRGJAKgESap3FqtTMUTX4oLv6KPGCbRZbxtEPVNGAhIIKxvMA7iCJFoyPV/7/UsEDvTQCdI89TV7Wzqa5Y8/cQItqX/ZRzO/ERINfzHjvqo8AkHV2vZ23+cqDzI
X-MS-Office365-Filtering-Correlation-Id: 28a966a7-559e-4d3a-a62f-08d5a20f3d98
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2018 13:54:27.5041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a966a7-559e-4d3a-a62f-08d5a20f3d98
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-13 19:46, Rob Herring wrote:
> On Mon, Apr 09, 2018 at 12:59:15PM +0200, Peter Rosin wrote:
>> Useful for beating cases where an output mode selection heuristic
>> fails.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> index 82f2acb3d374..dc478455b883 100644
>> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> @@ -10,6 +10,10 @@ Required properties:
>>   - #address-cells: should be set to 1.
>>   - #size-cells: should be set to 0.
>>  
>> +Optional properties:
>> + - output-mode: override any output mode selection hueristic and force a
>> +   particular output mode. One of "rgb444", "rgb565", "rgb666" and "rgb888".
>> +
> 
> This needs to be generic, not just added to some random display 
> controller binding.
> 
> It also belongs in the port or endpoint node as is done for camera 
> interfaces.

Hmm, should I extend media/video-interfaces.txt with more bus types (or since
I'm targeting parallel interfaces, perhaps the new bus types should be
autodetected from other props?) or should a write a new binding similar to
it?

One question regarding bus-width, should it include hsync/vsync/de/clk?
If yes, how to distinguish rgb565 with all those four from rgb666 with
only de/clk (some panels do not need hsync/vsync)? 20 lines in both
cases...

Or are rgb444/rgb565/rgb666/rgb888 already supported by the media video
interface binding? That's not at all obvious to me.

Cheers,
Peter
